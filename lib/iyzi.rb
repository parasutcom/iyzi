require 'iyzi/version'
require 'iyzi/configuration'
require 'iyzi/resources'
require 'iyzi/endpoints'
require 'iyzi/api_error'
require 'iyzi/utils'
require 'iyzi/currency'

# PKI Builders
require 'iyzi/pki_builder'
require 'iyzi/pki_builders/basket_item'
require 'iyzi/pki_builders/basket_items'
require 'iyzi/pki_builders/address'
require 'iyzi/pki_builders/buyer'
require 'iyzi/pki_builders/checkout_form'
require 'iyzi/pki_builders/checkout_form_auth'
require 'iyzi/pki_builders/sub_merchant'
require 'iyzi/pki_builders/card_storage'
require 'iyzi/pki_builders/payment_card'
require 'iyzi/pki_builders/store_card'
require 'iyzi/pki_builders/payment_auth'
require 'iyzi/pki_builders/bin_control'
require 'iyzi/pki_builders/installment_info'
require 'iyzi/pki_builders/threeds_initialize'
require 'iyzi/pki_builders/threeds_payment_create'

# Requests
require 'iyzi/request'
require 'iyzi/requests/api_test'
require 'iyzi/requests/checkout_form'
require 'iyzi/requests/checkout_form_auth'
require 'iyzi/requests/sub_merchant'
require 'iyzi/requests/card_storage'
require 'iyzi/requests/payment_auth'
require 'iyzi/requests/bin_control'
require 'iyzi/requests/installment_info'
require 'iyzi/requests/threeds_initialize'
require 'iyzi/requests/threeds_payment_create'
require 'iyzi/requests/instant_onboarding'

# Misc
require 'active_support/all'

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
