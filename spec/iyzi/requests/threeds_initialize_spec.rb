require 'spec_helper'

describe Iyzi::Requests::ThreedsInitialize do
  before { stub_random_string }
  let(:config) do
    Iyzi::Configuration.new(
      api_key:  ENV['IYZI_SANDBOX_API_KEY'] || 'x',
      secret:   ENV['IYZI_SANDBOX_SECRET'] || 'x',
      base_url: ENV['IYZI_SANDBOX_BASE_URL'] || 'https://sandbox-api.iyzipay.com/'
    )
  end

  context 'successful response' do
    cassette 'threeds_initialize/successful'

    let(:payment_card) do
      {
        card_holder_name: 'Genc Osman',
        card_number: '5528790000000008',
        expire_year: '2030',
        expire_month: '12',
        cvc: '123'
      }
    end

    let(:buyer) do
      {
        id: 'BY789',
        name: 'Genc',
        surname: 'Osman',
        identity_number: '1000001',
        email: 'genc@osman.com',
        registration_address: 'Tomtom Mah. Nur-i Ziya Sok. 16/1 34433 Beyoğlu',
        city: 'Istanbul',
        country: 'Turkey',
        ip: 'localhost'
      }
    end

    let(:address) do
      {
        address: 'Tomtom Mah. Nur-i Ziya Sok. 16/1 34433 Beyoğlu',
        contact_name: 'Genc Osman',
        city: 'Istanbul',
        country: 'Turkey'
      }
    end

    let(:item) do
      {
        id: 'PARASUT:1',
        name: 'Test Subscription',
        category1: 'Finance',
        category2: 'Online',
        item_type: 'VIRTUAL',
        price: '1'
      }
    end

    let(:params) do
      {
        locale: 'tr',
        conversation_id: '123456',
        price: 1,
        paid_price: 1,
        basket_id: 'TEST_BASKET_ID',
        payment_group: 'SUBSCRIPTION',
        callback_url: 'http://localhost/callback',
        payment_card: payment_card,
        buyer: buyer,
        billing_address: address,
        basket_items: [item]
      }
    end

    let(:request) { described_class.new(params.merge(config: config)) }

    it 'collects payment' do
      response = request.response

      expect(response['status']).to eq('success')
      expect(response['conversation_id']).to eq(params[:conversation_id])
      expect(response['three_ds_html_content']).to be_present
    end
  end

  context 'failed response' do
    cassette 'threeds_initialize/missing_fields'
    let(:params) { { price: 1, paid_price: 1 } }
    let(:request) { described_class.new(params.merge(config: config)) }

    it 'returns missing fields' do
      response = request.response

      expect(response['status']).to eq('failure')
      expect(response['error_code']).to eq('5013')
      expect(response['error_message']).to eq('PaymentCard gönderilmesi zorunludur')
    end
  end
end
