module Iyzi
  module PkiBuilders
    class Address < PkiBuilder
      ADDRESS_ATTRIBUTES_ORDER = %w{
        address
        zipCode
        contactName
        city
        country
      }.freeze

      ADDRESS_HASH_TYPE_CAST = {
        default: 'add'
      }.freeze

      def initialize(values = {})
        super({})
        return if values.nil?
        assign_params_by_order(values)
      end

      def assign_params_by_order(values)
        # there is a specific order that pki builder must obey
        ADDRESS_ATTRIBUTES_ORDER.each do |attribute|
          send(adder(attribute), attribute, values[attribute])
        end
      end

      def type_cast_hash
        ADDRESS_HASH_TYPE_CAST
      end
    end
  end
end
