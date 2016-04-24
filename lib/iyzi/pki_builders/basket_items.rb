module Iyzi
  module PkiBuilders
    class BasketItems
      attr_reader :items

      def initialize(basket_items = [])
        @items = basket_items
      end

      def request_array
        items.collect do |item|
          BasketItem.new(item).request_string
        end
      end
    end
  end
end
