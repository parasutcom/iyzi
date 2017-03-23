module Iyzi
  module PkiBuilders
    class InstallmentInfo < PkiBuilder
      ATTRIBUTES_ORDER = %w{
        locale
        conversationId
        binNumber
        price
      }.freeze

      TYPE_CAST = {
        price: 'add_price'
      }.freeze

      def initialize(values = {})
        super(values, ATTRIBUTES_ORDER, TYPE_CAST)
      end
    end
  end
end
