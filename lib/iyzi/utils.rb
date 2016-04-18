module Iyzi
  class Utils
    class << self
      def hash_to_properties(hash)
        newprops = {}
        hash.each_pair { |k, v| newprops[k.to_s.camelize(:lower)] = convert_to_prop(v) }
        newprops
      end

      def properties_to_hash(props)
        hash = HashWithIndifferentAccess.new
        props.each_pair { |k, v| hash[k.underscore] = convert_to_hash(v) }
        hash
      end

      def convert_to_prop(v)
        if v.is_a?(Hash)
          hash_to_properties(v)
        elsif v.is_a?(Array)
          v.collect { |item| hash_to_properties(item) }
        else
          v
        end
      end

      def convert_to_hash(v)
        if v.is_a?(Hash)
          properties_to_hash(v)
        elsif v.is_a?(Array)
          v.collect { |item| properties_to_hash(item) }
        else
          v
        end
      end
    end
  end
end