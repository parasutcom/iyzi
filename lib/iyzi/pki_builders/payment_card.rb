module Iyzi
  module PkiBuilders
    class PaymentCard < PkiBuilder
      ATTRIBUTES_ORDER = %w{
        locale
        conversationId
        cardHolderName
        cardNumber
        expireYear
        expireMonth
        cvc
        registerCard
        cardAlias
        cardToken
        cardUserKey
      }

      def initialize(values = {})
        super(values, ATTRIBUTES_ORDER)
      end
    end
  end
end
