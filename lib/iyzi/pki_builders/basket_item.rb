module Iyzi
  module PkiBuilders
    class BasketItem < PkiBuilder
      ATTRIBUTES_ORDER = %w{
        id
        price
        name
        category1
        category2
        itemType
        subMerchantKey
        subMerchantPrice
      }.freeze

      TYPE_CAST = {
        price:            'add_price',
        subMerchantPrice: 'add_price'
      }.freeze

      def initialize(values = {})
        super(values, ATTRIBUTES_ORDER, TYPE_CAST)
      end
    end
  end
end
