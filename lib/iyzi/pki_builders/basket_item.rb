module Iyzi
  module PkiBuilders
    class BasketItem < PkiBuilder
      ITEM_ATTRIBUTES_ORDER = %w{
        id
        price
        name
        category1
        category2
        itemType
        subMerchantKey
        subMerchantPrice
      }.freeze

      ITEM_HASH_TYPE_CAST = {
        default:          'add',
        price:            'add_price',
        subMerchantPrice: 'add_price'
      }.freeze

      def initialize(values = {})
        super({})
        Assigner.assign_params_by_order(self, ITEM_ATTRIBUTES_ORDER, values)
      end

      def type_cast_hash
        ITEM_HASH_TYPE_CAST
      end
    end
  end
end
