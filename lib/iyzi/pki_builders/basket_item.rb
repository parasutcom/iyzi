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
        # there is a specific order that pki builder must obey
        ITEM_ATTRIBUTES_ORDER.each do |attribute|
          send(adder(attribute), attribute, values[attribute])
        end
      end

      def type_cast_hash
        ITEM_HASH_TYPE_CAST
      end
    end
  end
end
