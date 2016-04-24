require 'spec_helper'

describe Iyzi::Requests::BinControl do
  before do
    stub_random_string
    Iyzi.configure do |config|
      config.api_key = 'x'
      config.secret = 'x'
    end
  end

  context 'succesful' do
    cassette 'bin_control_successful'
    let(:bin_number)  { '557023' }
    let(:bin_control) { described_class.new(bin_number: bin_number) }

    it 'gets bin number details' do
      response = bin_control.response
      expect(response['status']).to eq('success')
      expect(response['bin_number']).to eq(bin_number)
      expect(response['card_type']).to eq('CREDIT_CARD')
      expect(response['card_association']).to eq('MASTER_CARD')
      expect(response['card_family']).to eq('Bonus')
      expect(response['bank_name']).to eq('Garanti Bankası')
      expect(response['bank_code']).to eq(62)
    end
  end

  context 'failure' do
    cassette 'bin_control_failure'
    let(:bin_number)  { '411111' }
    let(:bin_control) { described_class.new(bin_number: bin_number) }

    it 'gets not found response' do
      response = bin_control.response
      expect(response['status']).to eq('failure')
      expect(response['error_code']).to eq('5066')
      expect(response['error_message']).to eq('Bin bulunamadı')
      expect(response['bin_number']).to eq(bin_number)
    end
  end
end
