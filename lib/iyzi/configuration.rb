module Iyzi
  class Configuration
    BASE_URL        = 'https://api.iyzipay.com/'.freeze
    REQUIRED_CONFIG = %i(base_url api_key secret).freeze
    attr_accessor :base_url, :api_key, :secret

    def initialize(options = {})
      @base_url = options[:base_url] || BASE_URL
      @api_key  = options[:api_key]
      @secret   = options[:secret]
    end

    def valid?
      !missing_configs.present?
    end

    def validate
      return if valid?
      fail "Missing configuration keys: #{missing_configs.collect(&:to_s).join(', ')}"
    end

    def missing_configs
      REQUIRED_CONFIG - defined_params.keys.collect(&:to_sym)
    end

    def defined_params
      to_h.select { |k, v| v.present? }
    end

    def to_h
      {
        base_url: base_url,
        api_key:  api_key,
        secret:   secret
      }
    end
  end
end
