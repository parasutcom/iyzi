module Iyzi
  class PkiBuilder
    DEFAULT_ADD_METHOD = 'add'

    attr_accessor :params, :ordered_keys

    def initialize(values = {}, ordered_keys = nil, type_cast = {})
      @params = {}
      assign_params(values, type_cast)
      @ordered_keys = ordered_keys
    end

    def request_string
      str = prepare_request_string
      "[#{str}]" unless str.empty?
    end

    def prepare_request_string
      ordered_params.join(',')
    end

    def ordered_params
      orderer.map do |key|
        convert_str(key, params[key]) if params[key].present?
      end.reject(&:nil?)
    end

    def add_price(key, value)
      add(key, value.to_f.round(2)) if value.to_f != 0
    end

    def add_array(key, value)
      add(key, "[#{value.join(', ')}]") if value.present?
    end

    def add_date(key, value)
      add(key, parse_date(value).strftime('%Y-%m-%d %H:%M:%S')) if value.present?
    end

    def add_buyer(key, value)
      add(key, PkiBuilders::Buyer.new(value).request_string)
    end

    def add_address(key, value)
      add(key, PkiBuilders::Address.new(value).request_string)
    end

    def add_basket_items(key, value)
      add_array(key, PkiBuilders::BasketItems.new(value).request_array)
    end

    def add_payment_card(key, value)
      add(key, PkiBuilders::PaymentCard.new(value).request_string)
    end

    def add_store_card(key, value)
      add(key, PkiBuilders::StoreCard.new(value).request_string)
    end

    def add(key, value)
      params[key] = value.to_s unless value.to_s.empty?
    end

    def convert_str(key, value)
      "#{key}=#{value}"
    end

    def parse_date(value)
      value.is_a?(String) ? DateTime.parse(value) : value
    end

    private

    def orderer
      ordered_keys || params.keys
    end

    def assign_params(values, type_cast)
      values.each_pair do |key, value|
        send(adder(type_cast[key.to_sym]), key, value)
      end
    end

    def adder(add_method)
      add_method || DEFAULT_ADD_METHOD
    end
  end
end
