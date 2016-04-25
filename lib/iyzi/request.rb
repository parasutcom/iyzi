require 'faraday'
require 'faraday_middleware'

module Iyzi
  class Request
    AUTHORIZATION_HEADER_NAME   = 'Authorization'.freeze
    RANDOM_HEADER_NAME          = 'x-iyzi-rnd'.freeze
    AUTHORIZATION_HEADER_STRING = 'IYZWS %s:%s'.freeze
    DEFAULT_LOCALE              = 'tr'.freeze

    attr_accessor :config, :method, :path, :conversation_id, :locale, :random_string, :pki, :options

    def initialize(method, path, options = {})
      @method = method
      @path   = path
      # use default config which comes from initial setup
      # you can also send custom config object which you'd like to use
      @config          = options.delete(:config) || Iyzi.configuration
      @options         = options
      @locale          = options[:locale] || DEFAULT_LOCALE
      @conversation_id = options[:conversation_id]
      @pki             = to_pki
      @random_string   = secure_random_string
    end

    def iyzi_options
      Utils.hash_to_properties(options)
    end

    def connection
      @conn ||= Faraday.new(url: config.base_url) do |faraday|
        faraday.request  :json
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        faraday.response :json, content_type: /\bjson$/
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
      format(AUTHORIZATION_HEADER_STRING, config.api_key, request_hash_digest)
    end

    def request_hash_digest
      Digest::SHA1.base64digest(params_will_be_hashed)
    end

    def params_will_be_hashed
      config.api_key + random_string + config.secret + pki
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
  end
end
