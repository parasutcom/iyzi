module Iyzi
  module Requests
    class SubMerchant < Request
      attr_accessor :type

      class << self
        def create(options)
          new(:create, Endpoints::HTTP_POST, Endpoints::SUB_MERCHANT_CREATE, options)
        end

        def update(options)
          new(:update, Endpoints::HTTP_PUT, Endpoints::SUB_MERCHANT_UPDATE, options)
        end

        def retreive(options)
          new(:retreive, Endpoints::HTTP_POST, Endpoints::SUB_MERCHANT_DETAIL, options)
        end
      end

      def initialize(type, method, path, options = {})
        @type = type
        super(method, path, options)
      end

      def to_pki
        PkiBuilders::SubMerchant.new(type, iyzi_options).request_string
      end
    end
  end
end
