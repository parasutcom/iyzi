module Iyzi
  module PkiBuilders
    class PaymentAuth < PkiBuilder
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
      }.freeze

      TYPE_CAST = {
        default:         'add',
        price:           'add_price',
        paidPrice:       'add_price',
        paymentCard:     'add_payment_card',
        buyer:           'add_buyer',
        shippingAddress: 'add_address',
        billingAddress:  'add_address',
        basketItems:     'add_basket_items'
      }.freeze

      def initialize(values = {})
        super({})
        Assigner.assign_params_by_order(self, ATTRIBUTES_ORDER, values)
      end

      def type_cast_hash
        TYPE_CAST
      end
    end
  end
end
