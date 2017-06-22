require 'spec_helper'

describe Iyzi::Requests::ThreedsPaymentCreate do
  before { stub_random_string }
  let(:config) do
    Iyzi::Configuration.new(
      api_key:  ENV['IYZI_SANDBOX_API_KEY'] || 'x',
      secret:   ENV['IYZI_SANDBOX_SECRET'] || 'x',
      base_url: ENV['IYZI_SANDBOX_BASE_URL'] || 'https://sandbox-api.iyzipay.com/'
    )
  end

  context 'successful response' do
    cassette 'threeds_payment_create/successful'

    let(:params) do
      {
        payment_id: '393562'
      }
    end

    let(:request) { described_class.new(params.merge(config: config)) }

    it 'collects payment' do
      response = request.response

      expect(response['status']).to eq('success')
      expect(response['price']).to eq(10.0)
      expect(response['paid_price']).to eq(10.0)

      expect(response['status']).to eq('success')
      expect(response['price']).to eq(10.0)
      expect(response['paid_price']).to eq(10.0)
      expect(response['payment_id']).to eq('393562')
      expect(response['fraud_status']).to eq(1)
      expect(response['card_type']).to eq('CREDIT_CARD')
      expect(response['bin_number']).to eq('552608')
      expect(response['item_transactions']).to be_kind_of(Array)
      tx = response['item_transactions'][0]
      expect(tx['item_id']).to eq('BI101')
      expect(tx['price']).to eq(10.0)
      expect(tx['paid_price']).to eq(10.0)
    end
  end

  context 'failed response' do
    cassette 'threeds_payment_create/missing_fields'
    let(:params) { { conversation_id: 123 } }
    let(:request) { described_class.new(params.merge(config: config)) }

    it 'returns missing fields' do
      response = request.response

      expect(response['status']).to eq('failure')
      expect(response['error_code']).to eq('5002')
      expect(response['error_message']).to eq('paymentId gönderilmesi zorunludur')
    end
  end
end
