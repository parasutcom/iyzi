module Iyzi
  module PkiBuilders
    class CheckoutFormAuth < PkiBuilder
      ATTRIBUTES_ORDER = %w{
        locale
        conversationId
        token
      }.freeze

      def initialize(values = {})
        super(values, ATTRIBUTES_ORDER)
      end
    end
  end
end
