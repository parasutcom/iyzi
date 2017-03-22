require 'spec_helper'

describe Iyzi::Requests::InstallmentInfo do
  let(:config) { Iyzi::Configuration.new(api_key:  ENV['IYZI_SANDBOX_API_KEY'],
                                         secret:   ENV['IYZI_SANDBOX_SECRET'],
                                         base_url: ENV['IYZI_SANDBOX_BASE_URL']) }

  before { stub_random_string }

  context 'successful' do
    context 'valid_params'
    cassette 'installment_info/valid_params'

    let(:params) do
      {
        locale: 'tr',
        conversation_id: '123456',
        binNumber: '552608',
        price: 100
      }
    end

    let(:installment_info) { described_class.new(params.merge(config: config)) }

    it 'returns installment numbers' do
      installment_details = installment_info.response['installment_details']
      installment_prices = installment_details[0]['installment_prices']

      expect(installment_prices[0]).to include('installment_number')
    end

    it 'returns total prices' do
      installment_details = installment_info.response['installment_details']
      installment_prices = installment_details[0]['installment_prices']

      expect(installment_prices[2]).to include('total_price')
    end

    it 'returns installment price ' do
      installment_details = installment_info.response['installment_details']
      installment_prices = installment_details[0]['installment_prices']

      expect(installment_prices[3]).to include('installment_price')
    end
  end

  context 'failure' do
    context 'invalid params' do
      cassette 'installment_info/invalid_params'

      let(:params) do
        {
          locale: 'tr',
          conversation_id: '123456',
          binNumber: 'xxxxxx',
          price: 100
        }
      end

      let(:installment_info) { described_class.new(params.merge(config: config)) }

      it 'does not include installment_prices' do
        installment_details = installment_info.response['installment_details']
        installment_prices = installment_details[0]['installment_prices']

        # incorrect binNumber results in full payment and returns
        # only installment_prices[0]
        expect(installment_prices[1]).to be_falsey
      end
    end
  end
end
