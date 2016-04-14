module Iyzi
  module PkiBuilders
    class Buyer < PkiBuilder
      BUYER_ATTRIBUTES_ORDER = %w{
        id
        name
        surname
        identityNumber
        email
        gsmNumber
        registrationDate
        lastLoginDate
        registrationAddress
        city
        country
        zipCode
        ip
      }.freeze

      BUYER_HASH_TYPE_CAST = {
        default:          'add',
        registrationDate: 'add_date',
        lastLoginDate:    'add_date'
      }.freeze

      def initialize(values = {})
        super({})
        # there is a specific order that pki builder must obey
        BUYER_ATTRIBUTES_ORDER.each do |attribute|
          send(adder(attribute), attribute, values[attribute])
        end
      end

      def type_cast_hash
        BUYER_HASH_TYPE_CAST
      end
    end
  end
end
