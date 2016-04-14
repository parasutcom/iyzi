module Iyzi
  module Requests
    class CheckoutFormAuth < Request
      def initialize(options = {})
        super(Endpoints::HTTP_POST, Endpoints::CHECKOUT_FORM_AUTH, options)
      end

      def to_pki
        builder = Iyzi::PkiBuilder.new
        builder.add('locale', options['locale'])
        builder.add('conversationId', options['conversationId'])
        builder.add('token', options['token'])
        builder.request_string
      end
    end
  end
end
