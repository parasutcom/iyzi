module Iyzi
  module PkiBuilders
    class Assigner < PkiBuilder
      def self.assign_params_by_order(object, order, values)
        return if values.nil?
        # there is a specific order that pki builder must obey
        values = Utils.hash_to_properties(values).with_indifferent_access
        order.each do |attribute|
          object.send(adder(object, attribute), attribute, values[attribute])
        end
      end

      def self.adder(object, attribute)
        object.type_cast_hash[attribute.to_sym] || object.type_cast_hash[:default]
      end
    end
  end
end
