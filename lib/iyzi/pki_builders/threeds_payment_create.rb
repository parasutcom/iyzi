module Iyzi
  module PkiBuilders
    class ThreedsPaymentCreate < PkiBuilder
      ATTRIBUTES_ORDER = %w{
        locale
        conversationId
        paymentId
        conversationData
      }.freeze

      def initialize(values = {})
        super(values, ATTRIBUTES_ORDER)
      end
    end
  end
end
