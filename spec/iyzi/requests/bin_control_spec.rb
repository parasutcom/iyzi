require 'spec_helper'

describe Iyzi::Requests::BinControl do
  let(:config) { Iyzi::Configuration.new(api_key:  ENV['IYZI_SANDBOX_API_KEY'],
                                         secret:   ENV['IYZI_SANDBOX_SECRET'],
                                         base_url: ENV['IYZI_SANDBOX_BASE_URL']) }

  before { stub_random_string }

  context 'succesful' do
    cassette 'bin_control/successful'
    let(:bin_number)  { '557023' }
    let(:bin_control) { described_class.new(bin_number: bin_number, 
                                            config:     config) }

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
    cassette 'bin_control/failure'
    let(:bin_number)  { '411111' }
    let(:bin_control) { described_class.new(bin_number: bin_number, config: config) }

    it 'gets not found response' do
      response = bin_control.response
      expect(response['status']).to eq('failure')
      expect(response['error_code']).to eq('5066')
      expect(response['error_message']).to eq('Bin bulunamadı')
      expect(response['bin_number']).to eq(bin_number)
    end
  end
end
