require 'spec_helper'

describe Iyzi::Requests::CheckoutForm do
  include CheckoutFormHelper
  before { stub_random_string }

  let(:config) { Iyzi::Configuration.new(api_key: 'x', secret: 'x') }
  let(:options) do
    {
      locale:          'tr',
      conversation_id: '123456',
      price:           total_price,
      paid_price:      total_price,
      basket_id:       'B67832',
      payment_group:   'PRODUCT',
      callback_url:    'https://eda1f961.ngrok.io/callback',
      buyer:           buyer,
      billing_address: address,
      basket_items:    items
    }
  end

  let(:buyer) do
    {
      id:                   'BY789',
      name:                 'John',
      surname:              'Doe',
      identity_number:      '74300864791',
      email:                'email@email.com',
      gsm_number:           '+905350000000',
      registration_date:    '2013-04-21 15:12:09',
      last_login_date:      '2015-10-05 12:43:35',
      registration_address: 'Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1',
      city:                 'Istanbul',
      country:              'Turkey',
      zip_code:             '34732',
      ip:                   '85.34.78.112'
    }
  end

  let(:address) do
    {
      address:      'Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1',
      zip_code:     '34732',
      contact_name: 'Jane Doe',
      city:         'Istanbul',
      country:      'Turkey'
    }
  end

  let(:items) { [create_item, create_item(id: 'I12', price: '2')] }
  let(:total_price) { items.collect { |a| a['price'].to_f }.inject(:+).to_s }

  describe '#to_pki' do
    let(:form_request) { described_class.new(options.merge(config: config)) }

    it 'generates pki string' do
      expect(form_request.to_pki).to eq('[locale=tr,conversationId=123456,price=3.0,' \
        'basketId=B67832,paymentGroup=PRODUCT,buyer=[id=BY789,name=John,surname=Doe,' \
        'identityNumber=74300864791,email=email@email.com,gsmNumber=+905350000000,' \
        'registrationDate=2013-04-21 15:12:09,lastLoginDate=2015-10-05 12:43:35,' \
        'registrationAddress=Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1,' \
        'city=Istanbul,country=Turkey,zipCode=34732,ip=85.34.78.112],billingAddress=' \
        '[address=Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1,zipCode=34732,' \
        'contactName=Jane Doe,city=Istanbul,country=Turkey],basketItems=[[id=BI102,' \
        'price=1.0,name=Game code,category1=Game,category2=Online Game Items,itemType=VIRTUAL], ' \
        '[id=I12,price=2.0,name=Game code,category1=Game,category2=Online Game Items,itemType=VIRTUAL]],' \
        'callbackUrl=https://eda1f961.ngrok.io/callback,paidPrice=3.0]')
    end
  end

  describe '#response' do
    context 'successful response' do
      let(:form_request) { described_class.new(options.merge(config: config)) }
      cassette 'successful_checkout_form'

      it 'returns success' do
        response = form_request.response
        expect(response['status']).to eq('success')
        expect(response['locale']).to eq(options[:locale])
        expect(response['conversation_id']).to eq(options[:conversation_id])
        expect(response['checkout_form_content']).not_to be_nil
        expect(response['payment_page_url']).not_to be_nil
      end
    end

    context 'failed response' do
      context 'api_key not found' do
        cassette 'api_key_not_found'
        let(:form_request) { described_class.new(options.merge(config: config)) }

        it 'returns error' do
          response = form_request.response
          expect(response['status']).to eq('failure')
          expect(response['error_code']).to eq('1001')
          expect(response['error_message']).to eq('api bilgileri bulunamadı')
          expect(response['locale']).to eq(options[:locale])
          expect(response['conversation_id']).to eq(options[:conversation_id])
        end
      end

      context 'missing attributes' do
        cassette 'checkout_form_missing_attribute'
        # price is a required field
        before { options.delete(:price) }
        let(:form_request) { described_class.new(options.merge(config: config)) }

        it 'returns error' do
          response = form_request.response
          expect(response['status']).to eq('failure')
          expect(response['error_code']).to eq('5004')
          expect(response['error_message']).to eq('price gönderilmesi zorunludur')
          expect(response['locale']).to eq(options[:locale])
          expect(response['conversation_id']).to eq(options[:conversation_id])
        end
      end

      context 'invalid signature' do
        cassette 'checkout_form_invalid_signature'
        let(:form_request) { described_class.new(options.merge(config: config)) }

        before do
          allow_any_instance_of(described_class).to receive(:to_pki).and_return('invalid')
        end

        it 'returns error' do
          response = form_request.response
          expect(response['status']).to eq('failure')
          expect(response['error_code']).to eq('1000')
          expect(response['error_message']).to eq('Geçersiz imza')
          expect(response['locale']).to eq(options[:locale])
          expect(response['conversation_id']).to eq(options[:conversation_id])
        end
      end
    end
  end
end
