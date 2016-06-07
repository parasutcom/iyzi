require 'spec_helper'

describe Iyzi::Requests::PaymentAuth do
  before { stub_random_string }
  let(:config) { Iyzi::Configuration.new(api_key: 'x', secret: 'x') }

  context 'successful response' do
    cassette 'payment_auth/successful'
    let(:payment_card) { { card_token: 'TggW8eg3fDucmCxSkPqAloBsoVA=', card_user_key: 'hd5F9J+IE6BxZCoT9rctolTE9EI=' } }
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
        payment_card: payment_card,
        buyer: buyer,
        billing_address: address,
        basket_items: [item]
      }
    end
    let(:payment_request) { described_class.new(params.merge(config: config)) }

    it 'collects payment' do
      response = payment_request.response
      expect(response['status']).to eq('success')
      expect(response['conversation_id']).to eq(params[:conversation_id])
      expect(response['price']).to eq(params[:price])
      expect(response['paid_price']).to eq(params[:paid_price])
      expect(response['payment_id']).not_to be_nil
      expect(response['fraud_status']).to eq(1)
      expect(response['card_type']).to eq('CREDIT_CARD')
      expect(response['card_association']).to eq('VISA')
      expect(response['card_family']).to eq('Maximum')
      expect(response['bin_number']).to eq('418342')
      expect(response['basket_id']).to eq(params[:basket_id])
      expect(response['item_transactions']).to be_kind_of(Array)
      tx = response['item_transactions'][0]
      expect(tx['item_id']).to eq(item[:id])
      expect(tx['payment_transaction_id']).not_to be_nil
      expect(tx['price'].to_s).to eq(item[:price])
      expect(tx['paid_price'].to_i.to_s).to eq(item[:price])
    end
  end

  context 'failed response' do
    cassette 'payment_auth/missing_fields'
    let(:params) { { price: 1, paid_price: 1} }
    let(:payment_request) { described_class.new(params.merge(config: config)) }

    it 'returns missing fields' do
      response = payment_request.response
      expect(response['status']).to eq('failure')
      expect(response['error_code']).to eq('5013')
      expect(response['error_message']).to eq('PaymentCard gönderilmesi zorunludur')
    end
  end
end
