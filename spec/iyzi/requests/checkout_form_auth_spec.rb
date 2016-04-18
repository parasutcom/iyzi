require 'spec_helper'

describe Iyzi::Requests::CheckoutFormAuth do
  let(:config) { Iyzi::Configuration.new(api_key: 'x', secret: 'x') }
  let(:options) { { 'locale' => 'tr', 'conversationId' => '123456', 'token' => token } }
  let(:token) { '87ed39e6-a125-46ff-81c0-XXXX' }

  before { stub_random_string }

  describe '#to_pki' do
    let(:form_request) { described_class.new(options) }
    let(:token) { 'TOKEN' }
    it 'generates pki string' do
      expect(form_request.to_pki).to eq('[locale=tr,conversationId=123456,token=TOKEN]')
    end
  end


  describe '#response' do
    context 'successful response' do
      cassette 'successful_checkout_form_auth'
      let(:auth_request) { described_class.new(options.merge(config: config)) }

      it 'returns payment status' do
        response = auth_request.response
        expect(response['status']).to eq('success')
        expect(response['locale']).to eq(options['locale'])
        expect(response['conversation_id']).to eq(options['conversationId'])
        expect(response['price']).to eq(1)
        expect(response['paid_price']).to eq(1)
        expect(response['payment_id']).not_to be_nil
        expect(response['fraud_status']).not_to be_nil
        expect(response['item_transactions']).to be_kind_of(Array)
        expect(response['token']).to eq(token)
        expect(response['payment_status']).to eq('SUCCESS')
      end
    end

    skip 'failed response' do
    end
  end
end