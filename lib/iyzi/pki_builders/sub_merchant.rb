module Iyzi
  module PkiBuilders
    class SubMerchant < PkiBuilder
      CREATE_ATTRIBUTES_ORDER = %w{
        locale
        conversationId
        name
        email
        gsmNumber
        address
        iban
        taxOffice
        contactName
        contactSurname
        legalCompanyTitle
        subMerchantExternalId
        identityNumber
        taxNumber
        subMerchantType
      }.freeze

      UPDATE_ATTRIBUTE_ORDER = %w{
        locale
        conversationId
        name
        email
        gsmNumber
        address
        iban
        taxOffice
        contactName
        contactSurname
        legalCompanyTitle
        subMerchantKey
        identityNumber
        taxNumber
      }

      RETREIVE_ATTRIBUTE_ORDER = %w{
        locale
        conversationId
        subMerchantExternalId
      }

      def initialize(type, values = {})
        super(values, order_for(type))
      end

      def order_for(type)
        case type
        when :create
          CREATE_ATTRIBUTES_ORDER
        when :update
          UPDATE_ATTRIBUTE_ORDER
        when :retreive
          RETREIVE_ATTRIBUTE_ORDER
        else
          raise "no attribute order for #{type}"
        end
      end
    end
  end
end
