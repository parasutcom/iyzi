module Iyzi
  module PkiBuilders
    class BinControl < PkiBuilder
      ATTRIBUTES_ORDER = %w{
        locale
        conversationId
        binNumber
      }

      def initialize(values = {})
        super(values, ATTRIBUTES_ORDER)
      end
    end
  end
end
