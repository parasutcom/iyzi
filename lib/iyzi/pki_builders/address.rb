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
        Assigner.assign_params_by_order(self, ADDRESS_ATTRIBUTES_ORDER, values)
      end

      def type_cast_hash
        ADDRESS_HASH_TYPE_CAST
      end
    end
  end
end
