module Iyzi
  class Configuration
    BASE_URL = 'https://api.iyzipay.com/'.freeze

    attr_accessor :base_url, :api_key, :secret

    def initialize(options = {})
      @base_url = options[:base_url] || BASE_URL
      @api_key  = options[:api_key]
      @secret   = options[:secret]
    end
  end
end
