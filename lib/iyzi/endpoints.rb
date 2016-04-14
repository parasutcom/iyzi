module Iyzi
  module Endpoints
    API_TEST                 = '/payment/test'.freeze
    BIN_NUMBER               = '/payment/bin/check'.freeze
    CHECKOUT_FORM_INITIALIZE = '/payment/iyzipos/checkoutform/initialize/ecom'.freeze
    CHECKOUT_FORM_AUTH       = '/payment/iyzipos/checkoutform/auth/ecom/detail'.freeze

    # HTTP VERBS
    HTTP_POST = 'post'.freeze
    HTTP_GET  = 'get'.freeze
  end
end
