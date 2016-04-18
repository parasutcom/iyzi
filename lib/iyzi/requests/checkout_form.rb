module Iyzi
  module Requests
    class CheckoutForm < Request
      def initialize(options = {})
        super(Endpoints::HTTP_POST, Endpoints::CHECKOUT_FORM_INITIALIZE, options)
      end

      def to_pki
        PkiBuilders::CheckoutForm.new(iyzi_options).request_string
      end
    end
  end
end
