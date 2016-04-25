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
        card: 'add_store_card'
      }.freeze

      def initialize(values = {})
        super(values, ATTRIBUTES_ORDER, TYPE_CAST)
      end
    end
  end
end
