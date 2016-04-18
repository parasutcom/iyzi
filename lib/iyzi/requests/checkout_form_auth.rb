module Iyzi
  module Requests
    class CheckoutFormAuth < Request
      def initialize(options = {})
        super(Endpoints::HTTP_POST, Endpoints::CHECKOUT_FORM_AUTH, options)
      end

      def to_pki
        PkiBuilders::CheckoutFormAuth.new(iyzi_options).request_string
      end
    end
  end
end
