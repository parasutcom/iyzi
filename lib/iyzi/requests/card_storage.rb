module Iyzi
  module Requests
    class CardStorage < Request
      attr_accessor :type

      class << self
        def add(options)
          new(:add, Endpoints::HTTP_POST, Endpoints::CARD_STORAGE_ADD, options)
        end

        def delete(options)
          new(:delete, Endpoints::HTTP_DELETE, Endpoints::CARD_STORAGE_DELETE, options)
        end

        def list(options)
          new(:list, Endpoints::HTTP_POST, Endpoints::CARD_STORAGE_LIST, options)
        end
      end

      def initialize(type, method, path, options = {})
        @type = type
        super(method, path, options)
      end

      def to_pki
        PkiBuilders::CardStorage.new(iyzi_options).request_string
      end
    end
  end
end
