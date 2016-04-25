module Iyzi
  module PkiBuilders
    class Buyer < PkiBuilder
      ATTRIBUTES_ORDER = %w{
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

      TYPE_CAST = {
        registrationDate: 'add_date',
        lastLoginDate:    'add_date'
      }.freeze

      def initialize(values = {})
        super(values, ATTRIBUTES_ORDER, TYPE_CAST)
      end
    end
  end
end
