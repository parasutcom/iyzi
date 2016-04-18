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

      TYPE_CAST = {
        default: 'add'
      }.freeze

      def initialize(type, values = {})
        super({})
        Assigner.assign_params_by_order(self, order_for(type), values)
      end

      def type_cast_hash
        TYPE_CAST
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
