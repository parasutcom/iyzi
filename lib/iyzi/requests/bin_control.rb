module Iyzi
  module Requests
    class BinControl < Request
      def initialize(options = {})
        super(Endpoints::HTTP_POST, Endpoints::BIN_CONTROL, options)
      end

      def to_pki
        PkiBuilders::BinControl.new(iyzi_options).request_string
      end
    end
  end
end
