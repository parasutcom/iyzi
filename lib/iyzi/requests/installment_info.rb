module Iyzi
  module Requests
    class InstallmentInfo < Request
      def initialize(options = {})
        super(Endpoints::HTTP_POST, Endpoints::INSTALLMENT_INFO, options)
      end

      def to_pki
        PkiBuilders::InstallmentInfo.new(iyzi_options).request_string
      end
    end
  end
end
