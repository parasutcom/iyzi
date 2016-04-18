module Iyzi
  module PkiBuilders
    class CardStorage < PkiBuilder
      ATTRIBUTES_ORDER = %w{
        locale
        conversationId
        externalId
        email
        cardUserKey
        cardToken
        card
      }.freeze

      TYPE_CAST = {
        default: 'add',
        card:    'add_card'

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
