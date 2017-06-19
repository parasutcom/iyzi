module Iyzi
  module Requests
    class ThreedsInitialize < Request
      def initialize(options = {})
        super(Endpoints::HTTP_POST, Endpoints::THREEDS_INITIALIZE, options)
      end

      def to_pki
        PkiBuilders::ThreedsInitialize.new(iyzi_options).request_string
      end
    end
  end
end
