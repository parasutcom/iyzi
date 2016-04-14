module Iyzi
  module Requests
    class CheckoutForm < Request
      def initialize(options = {})
        super(Endpoints::HTTP_POST, Endpoints::CHECKOUT_FORM_INITIALIZE, options)
      end

      def to_pki
        builder = Iyzi::PkiBuilder.new
        builder.add('locale', options['locale'])
        builder.add('conversationId', options['conversationId'])
        builder.add_price('price', options['price'])
        builder.add('basketId', options['basketId'])
        builder.add('paymentGroup', options['paymentGroup'])

        # buyer
        buyer_builder = Iyzi::PkiBuilders::Buyer.new(options['buyer'])
        builder.add('buyer', buyer_builder.request_string)

        # shipping address
        address_builder = Iyzi::PkiBuilders::Address.new(options['shippingAddress'])
        builder.add('shippingAddress', address_builder.request_string)

        # billing address
        address_builder = Iyzi::PkiBuilders::Address.new(options['billingAddress'])
        builder.add('billingAddress', address_builder.request_string)

        # basket items
        item_builder = Iyzi::PkiBuilders::BasketItems.new(options['basketItems'])
        builder.add_array('basketItems', item_builder.request_array)

        builder.add('callbackUrl', options['callbackUrl'])
        builder.add('paymentSource', options['paymentSource'])
        builder.add('posOrderId', options['posOrderId'])
        builder.add_price('paidPrice', options['paidPrice'])
        builder.add('forceThreeDS', options['forceThreeDS'])
        builder.add('cardUserKey', options['cardUserKey'])
        builder.request_string
      end
    end
  end
end
