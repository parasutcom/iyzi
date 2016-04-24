module Iyzi
  module Resources
    def api_test
      Requests::ApiTest.new
    end

    def checkout_form(options)
      Requests::CheckoutForm.new(options)
    end

    def checkout_form_auth(options)
      Requests::CheckoutFormAuth.new(options)
    end

    def payment_auth(options, &block)
      Requests::PaymentAuth.new(options).response(&block)
    end

    def register_card(options, &block)
      Requests::CardStorage.add(options).response(&block)
    end

    def bin_control(options, &block)
      Requests::BinControl.new(options).response(&block)
    end
  end
end
