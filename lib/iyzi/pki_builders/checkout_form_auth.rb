module Iyzi
  module PkiBuilders
    class CheckoutFormAuth < PkiBuilder
      ATTRIBUTES_ORDER = %w{
        locale
        conversationId
        token
      }.freeze

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
