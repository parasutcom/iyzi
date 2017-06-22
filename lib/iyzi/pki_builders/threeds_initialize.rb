module Iyzi
  module PkiBuilders
    class ThreedsInitialize < PkiBuilder
      ATTRIBUTES_ORDER = %w{
        locale
        conversationId
        price
        paidPrice
        installment
        paymentChannel
        basketId
        paymentGroup
        paymentCard
        buyer
        shippingAddress
        billingAddress
        basketItems
        paymentSource
        currency
        posOrderId
        connectorName
        callbackUrl
      }.freeze

      TYPE_CAST = {
        price:           'add_price',
        paidPrice:       'add_price',
        paymentCard:     'add_payment_card',
        buyer:           'add_buyer',
        shippingAddress: 'add_address',
        billingAddress:  'add_address',
        basketItems:     'add_basket_items'
      }.freeze

      def initialize(values = {})
        super(values, ATTRIBUTES_ORDER, TYPE_CAST)
      end
    end
  end
end
