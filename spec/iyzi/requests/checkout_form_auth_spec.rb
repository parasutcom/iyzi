require 'spec_helper'

describe Iyzi::Requests::CheckoutFormAuth do
  let(:config) { Iyzi::Configuration.new(api_key:  ENV['IYZI_SANDBOX_API_KEY'],
                                         secret:   ENV['IYZI_SANDBOX_SECRET'],
                                         base_url: ENV['IYZI_SANDBOX_BASE_URL']) }

  let(:options) { { locale: 'tr', conversation_id: '123456', token: token } }
  let(:token) { '87ed39e6-a125-46ff-81c0-XXXX' }

  before { stub_random_string }

  describe '#to_pki' do
    let(:form_request) { described_class.new(options.merge(config: config)) }
    let(:token) { 'TOKEN' }
    it 'generates pki string' do
      expect(form_request.to_pki).to eq('[locale=tr,conversationId=123456,token=TOKEN]')
    end
  end

  describe '#response' do
    context 'successful response' do
      def check_success(response, options)
        expect(response['status']).to eq('success')
        expect(response['locale']).to eq(options[:locale])
        expect(response['conversation_id']).to eq(options[:conversation_id])
        expect(response['price']).to eq(3)
        expect(response['paid_price']).to eq(3)
        expect(response['payment_id']).not_to be_nil
        expect(response['fraud_status']).not_to be_nil
        expect(response['item_transactions']).to be_kind_of(Array)
        expect(response['token']).to eq(token)
        expect(response['payment_status']).to eq('SUCCESS')
        expect(response['currency']).to eq(options[:currency])
      end

      context 'currency is TRY' do
        cassette 'checkout_form_auth/successful'
        let(:auth_request) { described_class.new(options.merge(config: config)) }

        it 'returns payment status' do
          response = auth_request.response
          check_success(response, options)
        end
      end

      context 'currency is USD' do
        cassette 'checkout_form_auth/successful_usd'
        let(:token) { '314b498a-89d1-4550-9cbe-5f7be828a49c' }
        let(:options) { { locale: 'tr', conversation_id: '123456', token: token, currency: 'USD' } }
        let(:auth_request) { described_class.new(options.merge(config: config)) }

        it 'returns payment status' do
          response = auth_request.response
          check_success(response, options)
        end
      end
    end

    skip 'failed response' do
    end
  end
end