# Iyzi

[![Build Status](https://travis-ci.org/parasutcom/iyzi.svg?branch=master)](https://travis-ci.org/parasutcom/iyzi)
[![Code Climate](https://codeclimate.com/github/parasutcom/iyzi/badges/gpa.svg)](https://codeclimate.com/github/parasutcom/iyzi)
[![Test Coverage](https://codeclimate.com/github/parasutcom/iyzi/badges/coverage.svg)](https://codeclimate.com/github/parasutcom/iyzi/coverage)

Iyzico ruby client

Checkout api documentations
https://www.iyzico.com/entegrasyon/ozel-yazilim-entegrasyonu/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'iyzi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install iyzi

## Setup

Before using the library, you must supply your Iyzico API key and secret. There are two ways to configure. You can either put the code below into initializer:
```ruby
Iyzi.configure do |config|
  config.api_key  = 'API_KEY'
  config.secret   = 'SECRET'
  config.base_url = 'BASE_API_URL' # default 'https://api.iyzipay.com/' if not specified
end
```
or you could send configuration object as a parameter
```ruby
config = Iyzi::Configuration.new(api_key: 'API_KEY', secret: 'SECRET')
params = { bin_number: '411111', config: config }
Iyzi.bin_control(params)
```

## Usage

Checkout [examples](examples.md)

## Supported Endpoints
Checked items are supported

- [x] Yeni Alt Üye İşyeri Ekleme Servisi /onboarding/submerchant POST
- [x] Alt Üye İşyeri Güncelleme Servisi /onboarding/submerchant PUT
- [ ] Ödeme (Auth) Servisi /payment/iyzipos/auth/ecom POST
- [ ] 3D Secure Ödeme (initialize 3DS) Başlatma Servisi /payment/iyzipos/initialize3ds/ecom POST
- [ ] 3D Secure Ödeme (Auth 3DS) Servisi /payment/iyzipos/auth3ds/ecom POST
- [ ] Ön Otorizasyon (PreAuth) Servisi /payment/iyzipos/preauth/ecom POST
- [ ] Son Otorizasyon (PostAuth=Capture) Servisi /payment/iyzipos/postauth POST
- [ ] İptal (Cancel) Servisi /payment/iyzipos/cancel POST
- [ ] İade (Refund) Servisi /payment/iyzipos/refund POST
- [ ] İade (Refund) Servisi - İadeyi Üye İşyerinin Üstlendiği /payment/iyzipos/refund/merchant/charge POST
- [ ] Para Transferi İçin Ürüne Onay Verme Servisi /payment/iyzipos/item/approve POST
- [ ] Para Transferi İçin Ürüne Verilen Onayı Geri Çekme Servisi /payment/iyzipos/item/disapprove POST
- [ ] Mahsuplaşma - Alt Üye İşyerine Para Gönderme Servisi /crossbooking/send POST
- [ ] Mahsuplaşma - Alt Üye İşyerinden Para Alma Servisi /crossbooking/receive POST
- [x] Servis Ayakta mı Testi (Healthcheck) /payment/test GET
- [x] BIN Kontrol Servisi /payment/bin/check POST
- [ ] Taksit Matrisi (Installment) Servisi /payment/iyzipos/installment POST
- [x] Ödemeden Bağımsız Kart Ekleme Servisi /cardstorage/card POST
- [x] Ödemeden Bağımsız Kart Silme Servisi /cardstorage/card DELETE
- [x] Ödemeden Bağımsız Kart Bilgilerini Çekme Servisi /cardstorage/cards POST
- [ ] Parası Transferi Yapılan İşlemler Servisi /reporting/settlement/payoutcompleted POST
- [ ] Para Transferi Bankadan Geri Dönenler Servisi /reporting/settlement/bounced POST
- [x] initializeCheckoutForm /payment/iyzipos/checkoutform/initialize/ecom POST
- [x] Callback & getAuthResponse /payment/iyzipos/checkoutform/auth/ecom/detail POST

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

