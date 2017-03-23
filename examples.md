### Api Test
```ruby
Iyzi.api_test
#=> {"status"=>"success", "locale"=>"tr", "system_time"=>1461684700719}
```

### Checkout Form
```ruby
params = {
             :locale => "tr",
    :conversation_id => "123456",
              :price => "3.0",
         :paid_price => "3.0",
          :basket_id => "B67832",
      :payment_group => "PRODUCT",
       :callback_url => "https://eda1f961.ngrok.io/callback",
              :buyer => {
                          :id => "BY789",
                        :name => "John",
                     :surname => "Doe",
             :identity_number => "74300864791",
                       :email => "email@email.com",
                  :gsm_number => "+905350000000",
           :registration_date => "2013-04-21 15:12:09",
             :last_login_date => "2015-10-05 12:43:35",
        :registration_address => "Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1",
                        :city => "Istanbul",
                     :country => "Turkey",
                    :zip_code => "34732",
                          :ip => "85.34.78.112"
    },
    :billing_address => {
             :address => "Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1",
            :zip_code => "34732",
        :contact_name => "Jane Doe",
                :city => "Istanbul",
             :country => "Turkey"
    },
       :basket_items => [
        {
                   "id" => "BI102",
                 "name" => "Game code",
            "category1" => "Game",
            "category2" => "Online Game Items",
             "itemType" => "VIRTUAL",
                "price" => "1"
        },
        {
                   "id" => "I12",
                 "name" => "Game code",
            "category1" => "Game",
            "category2" => "Online Game Items",
             "itemType" => "VIRTUAL",
                "price" => "2"
        }
    ]
}
Iyzi.checkout_form(options)
#=> {
#                   "status" => "success",
#                   "locale" => "tr",
#              "system_time" => 1460588522560,
#          "conversation_id" => "123456",
#                    "token" => "TOKEN",
#    "checkout_form_content" => "<script type=\"text/javascript\">\nvar iyziInit = {token:'TOKEN',price:3.00,locale:'tr',baseUrl:'https://api.iyzipay.com',registerCardEnabled:true,userCards:[], \ncreateTag:function(){\nvar iyziCSSTag = document.createElement('link');\niyziCSSTag.setAttribute('rel','stylesheet');\niyziCSSTag.setAttribute('type','text/css');\niyziCSSTag.setAttribute('href','https://static.iyzipay.com/checkoutform/css/main.min.css');\ndocument.head.appendChild(iyziCSSTag);\nvar iyziJSTag = document.createElement('script');\niyziJSTag.setAttribute('src','https://static.iyzipay.com/checkoutform/js/iyziCheckout.min.js');\ndocument.head.appendChild(iyziJSTag);\n}\n}\niyziInit.createTag();\n</script>\n",
#        "token_expire_time" => 1800,
#         "payment_page_url" => "https://cpp.iyzipay.com?token=TOKEN"
#}
```
### Checkout Form Auth
```ruby
params = {
             :locale => "tr",
    :conversation_id => "123456",
              :token => "87ed39e6-a125-46ff-81c0-XXXX"
}
Iyzi.checkout_form_auth(params)
#=> {
#                             "status" => "success",
#                             "locale" => "tr",
#                        "system_time" => 1460590653230,
#                    "conversation_id" => "123456",
#                              "price" => 1.0,
#                         "paid_price" => 1.0,
#                        "installment" => 1,
#                         "payment_id" => "PAYMENT_ID",
#                       "fraud_status" => 1,
#           "merchant_commission_rate" => 0.0,
#    "merchant_commission_rate_amount" => 0.0,
#        "iyzi_commission_rate_amount" => 0.0295,
#                "iyzi_commission_fee" => 0.295,
#                          "card_type" => "CREDIT_CARD",
#                   "card_association" => "VISA",
#                        "card_family" => "Maximum",
#                         "bin_number" => "411111",
#                          "basket_id" => "B67832",
#                  "item_transactions" => [
#        {
#                                      "item_id" => "BI102",
#                       "payment_transaction_id" => "PAYMENT_TRANSACTION_ID",
#                           "transaction_status" => 2,
#                                        "price" => 1.0,
#                                   "paid_price" => 1.0,
#                     "merchant_commission_rate" => 0.0,
#              "merchant_commission_rate_amount" => 0.0,
#                  "iyzi_commission_rate_amount" => 0.0295,
#                          "iyzi_commission_fee" => 0.295,
#                                "blockage_rate" => 0.0,
#                "blockage_rate_amount_merchant" => 0.0,
#            "blockage_rate_amount_sub_merchant" => 0.0,
#                       "blockage_resolved_date" => "2016-04-14 00:19:47",
#                           "sub_merchant_price" => 0.0,
#                     "sub_merchant_payout_rate" => 0.0,
#                   "sub_merchant_payout_amount" => 0.0,
#                       "merchant_payout_amount" => 0.6755
#        }
#    ],
#                              "token" => "XXXXXXX-XXXX-XXXX-XXXX-XXXX",
#                       "callback_url" => "https://eda1f961.ngrok.io/callback",
#                     "payment_status" => "SUCCESS"
#}
```
### Payment Auth
```ruby
params = {
             :locale => "tr",
    :conversation_id => "123456",
              :price => 1,
         :paid_price => 1,
          :basket_id => "TEST_BASKET_ID",
      :payment_group => "SUBSCRIPTION",
       :payment_card => {
           :card_token => "CARD_TOKEN",
        :card_user_key => "CARD_USER_KEY"
    },
              :buyer => {
                          :id => "BY789",
                        :name => "Genc",
                     :surname => "Osman",
             :identity_number => "1000001",
                       :email => "genc@osman.com",
        :registration_address => "Tomtom Mah. Nur-i Ziya Sok. 16/1 34433 Beyoğlu",
                        :city => "Istanbul",
                     :country => "Turkey",
                          :ip => "localhost"
    },
    :billing_address => {
             :address => "Tomtom Mah. Nur-i Ziya Sok. 16/1 34433 Beyoğlu",
        :contact_name => "Genc Osman",
                :city => "Istanbul",
             :country => "Turkey"
    },
       :basket_items => [
        {
                   :id => "PARASUT:1",
                 :name => "Test Subscription",
            :category1 => "Finance",
            :category2 => "Online",
            :item_type => "VIRTUAL",
                :price => "1"
        }
    ]
}
Iyzi.payment_auth(params)
#=> {
#                             "status" => "success",
#                             "locale" => "tr",
#                        "system_time" => 1461519398004,
#                    "conversation_id" => "123456",
#                              "price" => 1,
#                         "paid_price" => 1,
#                        "installment" => 1,
#                         "payment_id" => "3410766",
#                       "fraud_status" => 1,
#           "merchant_commission_rate" => 0.0,
#    "merchant_commission_rate_amount" => 0,
#        "iyzi_commission_rate_amount" => 0.0295,
#                "iyzi_commission_fee" => 0.295,
#                          "card_type" => "CREDIT_CARD",
#                   "card_association" => "VISA",
#                        "card_family" => "Maximum",
#                         "bin_number" => "418342",
#                          "basket_id" => "TEST_BASKET_ID",
#                  "item_transactions" => [{
#                                      "item_id" => "PARASUT:1",
#                       "payment_transaction_id" => "2774801",
#                           "transaction_status" => 2,
#                                        "price" => 1,
#                                   "paid_price" => 1.0,
#                     "merchant_commission_rate" => 0.0,
#              "merchant_commission_rate_amount" => 0.0,
#                  "iyzi_commission_rate_amount" => 0.0295,
#                          "iyzi_commission_fee" => 0.295,
#                                "blockage_rate" => 0.0,
#                "blockage_rate_amount_merchant" => 0.0,
#            "blockage_rate_amount_sub_merchant" => 0,
#                       "blockage_resolved_date" => "2016-04-24 20:36:37",
#                           "sub_merchant_price" => 0,
#                     "sub_merchant_payout_rate" => 0.0,
#                   "sub_merchant_payout_amount" => 0,
#                       "merchant_payout_amount" => 0.6755
#        }]
#}
```
### Register Card
```ruby
params = {
             :locale => "tr",
    :conversation_id => "123",
              :email => "email@email.com",
        :external_id => "321",
               :card => {
              :card_alias => "used in pardev",
        :card_holder_name => "John Doe",
             :card_number => "5528790000000008",
            :expire_month => "12",
             :expire_year => "2030"
    }
}
Iyzi.register_card(params)
#=> {
#              "status" => "success",
#              "locale" => "tr",
#         "system_time" => 1461507777282,
#     "conversation_id" => "123",
#         "external_id" => "321",
#               "email" => "email@email.com",
#       "card_user_key" => "CARD_USER_KEY",
#          "card_token" => "CARD_TOKEN",
#          "card_alias" => "used in pardev",
#          "bin_number" => "552879",
#           "card_type" => "CREDIT_CARD",
#    "card_association" => "MASTER_CARD",
#         "card_family" => "Paraf",
#      "card_bank_code" => 12,
#      "card_bank_name" => "Halk Bankası"
#}
```
### List Cards
```ruby
params = { card_user_key: "CARD_USER_KEY" }
Iyzi.list_cards(params)
#=> {
#           "status" => "success",
#           "locale" => "tr",
#      "system_time" => 1461512570878,
#    "card_user_key" => "CARD_USER_KEY",
#     "card_details" => [
#        {
#                  "card_token" => "CARD_TOKEN",
#                  "card_alias" => "used in pardev",
#                  "bin_number" => "552879",
#                   "card_type" => "CREDIT_CARD",
#            "card_association" => "MASTER_CARD",
#                 "card_family" => "Paraf",
#              "card_bank_code" => 12,
#              "card_bank_name" => "Halk Bankası"
#        }
#    ]
#}
```
### Delete Saved Card
```ruby
params = {
  :card_token    => "uYPntt0W4QZ8pFm6afLXCvWKjI8=",
  :card_user_key => "hK13yPTT0DPgs57+Y0lkfuDs1dc="
}
Iyzi.delete_card(params)
#=> { "status" => "success", "locale" => "tr", "system_time" => 1461510776404 }
```
### Bin Control
```ruby
params = { bin_number: '557023' }
Iyzi.bin_control(params)
#=> {
#              "status" => "success",
#              "locale" => "tr",
#         "system_time" => 1461422153162,
#          "bin_number" => "557023",
#           "card_type" => "CREDIT_CARD",
#    "card_association" => "MASTER_CARD",
#         "card_family" => "Bonus",
#           "bank_name" => "Garanti Bankası",
#           "bank_code" => 62
#}
```

### Installment Info
```ruby
params = {
  locale: 'tr',
  conversation_id: '123456',
  binNumber: '552608',
  price: 100
}
Iyzi.installment_info(params)
#=> {
#            "bin_number" => "552608",
#                 "price" => 100,
#             "card_type" => "CREDIT_CARD",
#      "card_association" => "MASTER_CARD",
#      "card_family_name" => "Axess",
#              "force3ds" => 0,
#             "bank_code" => 46,
#             "bank_name" => "Akbank",
#             "force_cvc" => 0,
#    "installment_prices" => [
#        [0] {
#             "installment_price" => 100,
#                   "total_price" => 100,
#            "installment_number" => 1
#        },
#        [1] {
#             "installment_price" => 51.09,
#                   "total_price" => 102.17,
#            "installment_number" => 2
#        },
#        [2] {
#             "installment_price" => 34.46,
#                   "total_price" => 103.39,
#            "installment_number" => 3
#        },
#        [3] {
#             "installment_price" => 17.81,
#                   "total_price" => 106.89,
#            "installment_number" => 6
#        },
#        [4] {
#             "installment_price" => 12.32,
#                   "total_price" => 110.92,
#            "installment_number" => 9
#        }
#    ]
# }
  ```
