require 'faraday'
require 'faraday_middleware'

module Iyzi
  class Request
    AUTHORIZATION_HEADER_NAME   = 'Authorization'.freeze
    RANDOM_HEADER_NAME          = 'x-iyzi-rnd'.freeze
    AUTHORIZATION_HEADER_STRING = 'IYZWSv2 %s'.freeze
    DEFAULT_LOCALE              = 'tr'.freeze

    attr_accessor :config, :method, :path, :random_string, :pki, :options

    def initialize(method, path, options = {})
      @method = method
      @path   = path
      # use default config which comes from initial setup
      # you can also send custom config object which you'd like to use
      @config             = options.delete(:config) || Iyzi.configuration
      @options            = options
      @options[:locale]   = options[:locale] || DEFAULT_LOCALE
      @options[:currency] = Currency.find(options[:currency]) if options[:currency].present?

      # In #add method of `PkiBuilder`, we ignore empty strings
      # So, in order to get valid signature, we need to make sure that
      # there is no empty value in request body
      deep_clean_empty_strings(@options)

      @pki                = to_pki
      @random_string      = secure_random_string
      # config must have all required params
      config.validate if has_pki?
    end

    def iyzi_options
      Utils.hash_to_properties(options.compact)
    end

    def connection
      @conn ||= Faraday.new(url: config.base_url) do |faraday|
        faraday.request  :json
        faraday.response :logger if ENV['DEBUG']
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    def call
      connection.send(method) do |req|
        req.url path
        req.headers['Accept'] = 'application/json'
        req.headers['Content-Type'] = 'application/json'
        req.headers.merge!(auth_headers) if has_pki?
        req.body = iyzi_options
      end
    end

    def response
      @response ||= Utils.properties_to_hash(call.body)
      block_given? ? yield(@response) : @response
    end

    def auth_headers
      {
        AUTHORIZATION_HEADER_NAME => auth_header_string,
        RANDOM_HEADER_NAME        => random_string
      }
    end

    def auth_header_string
      base64_string = Base64.strict_encode64("apiKey:#{config.api_key}&randomKey:#{random_string}&signature:#{encrypted_data}")
      format(AUTHORIZATION_HEADER_STRING, base64_string)
    end

    def encrypted_data
      OpenSSL::HMAC.hexdigest('SHA256', config.secret, data_to_encrypt)
    end

    def data_to_encrypt
      random_string + path + iyzi_options.to_json
    end

    def secure_random_string
      SecureRandom.urlsafe_base64(6, false)
    end

    def has_pki?
      !pki.nil? && !pki.to_s.empty?
    end

    # implement if needed
    def to_pki
      ''
    end

    def deep_clean_empty_strings(hash)
      hash.delete_if do |key, value|
        if value.is_a?(String) && value.empty?
          true
        elsif value.is_a?(Hash)
          deep_clean_empty_strings(value)
          value.empty?
        else
          false
        end
      end
    end
  end
end
