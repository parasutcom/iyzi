module Iyzi
  module Requests
    class PaymentAuth < Request
      def initialize(options = {})
        super(Endpoints::HTTP_POST, Endpoints::PAYMENT_AUTH_CREATE, options)
      end

      def to_pki
        PkiBuilders::PaymentAuth.new(iyzi_options).request_string
      end
    end
  end
end
