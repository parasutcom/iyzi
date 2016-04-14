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
  end
end
