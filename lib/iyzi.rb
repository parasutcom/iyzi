require 'iyzi/version'
require 'iyzi/configuration'
require 'iyzi/resources'
require 'iyzi/endpoints'
require 'iyzi/api_error'

# PKI Builders
require 'iyzi/pki_builder'
require 'iyzi/pki_builders/basket_item'
require 'iyzi/pki_builders/basket_items'
require 'iyzi/pki_builders/address'
require 'iyzi/pki_builders/buyer'
# Requests
require 'iyzi/request'
require 'iyzi/requests/api_test'
require 'iyzi/requests/checkout_form'
require 'iyzi/requests/checkout_form_auth'

module Iyzi
  extend Resources

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def reset
      @configuration = Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
