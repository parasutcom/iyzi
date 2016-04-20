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

      TYPE_CAST = {
        default: 'add'
      }.freeze

      def initialize(values = {})
        super({})
        Assigner.assign_params_by_order(self, ATTRIBUTES_ORDER, values)
      end

      def type_cast_hash
        TYPE_CAST
      end
    end
  end
end
