module Iyzi
  module Endpoints
    API_TEST                 = '/payment/test'.freeze
    BIN_CONTROL              = '/payment/bin/check'.freeze
    INSTALLMENT_INFO         = '/payment/iyzipos/installment'.freeze
    CHECKOUT_FORM_INITIALIZE = '/payment/iyzipos/checkoutform/initialize/ecom'.freeze
    CHECKOUT_FORM_AUTH       = '/payment/iyzipos/checkoutform/auth/ecom/detail'.freeze
    SUB_MERCHANT_CREATE      = '/onboarding/submerchant'.freeze
    SUB_MERCHANT_UPDATE      = '/onboarding/submerchant'.freeze
    SUB_MERCHANT_DETAIL      = '/onboarding/submerchant/detail'.freeze

    # CARD STORAGE
    CARD_STORAGE_ADD         = '/cardstorage/card'.freeze
    CARD_STORAGE_DELETE      = '/cardstorage/card'.freeze
    CARD_STORAGE_LIST        = '/cardstorage/cards'.freeze

    # PAYMENT AUTH
    PAYMENT_AUTH_CREATE      = '/payment/iyzipos/auth/ecom'.freeze

    # 3DS
    THREEDS_INITIALIZE       = '/payment/iyzipos/initialize3ds/ecom'.freeze
    THREEDS_PAYMENT_CREATE   = '/payment/iyzipos/auth3ds/ecom'.freeze

    # INSTANT ONBOARDING
    INSTANT_ONBOARDING_CREATE = '/api/v1/merchants'.freeze

    # HTTP VERBS
    HTTP_POST    = 'post'.freeze
    HTTP_GET     = 'get'.freeze
    HTTP_PUT     = 'put'.freeze
    HTTP_DELETE  = 'delete'.freeze
  end
end
