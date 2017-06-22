module Iyzi
  module Requests
    class ThreedsPaymentCreate < Request
      def initialize(options = {})
        super(Endpoints::HTTP_POST, Endpoints::THREEDS_PAYMENT_CREATE, options)
      end

      def to_pki
        PkiBuilders::ThreedsPaymentCreate.new(iyzi_options).request_string
      end
    end
  end
end
