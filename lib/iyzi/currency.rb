module Iyzi
  module Currency
    TRY = 'TRY'.freeze
    USD = 'USD'.freeze
    EUR = 'EUR'.freeze
    GBP = 'GBP'.freeze
    IRR = 'IRR'.freeze

    VALID_CURRENCIES = [TRY, USD, EUR, GBP, IRR].freeze

    def self.find(symbol)
      currency = VALID_CURRENCIES.select { |c| c == symbol.to_s.upcase }.first
      currency.present? ? currency : raise("currency must be one of these: #{VALID_CURRENCIES}")
    end
  end
end
