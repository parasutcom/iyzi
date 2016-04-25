module Iyzi
  module PkiBuilders
    class StoreCard < PkiBuilder
      ATTRIBUTES_ORDER = %w{
        locale
        conversationId
        cardAlias
        cardNumber
        expireYear
        expireMonth
        cardHolderName
      }

      def initialize(values = {})
        super(values, ATTRIBUTES_ORDER)
      end
    end
  end
end
