require 'spec_helper'

describe Iyzi::Requests::ApiTest do
  let(:config) { Iyzi::Configuration.new(api_key:  ENV['IYZI_SANDBOX_API_KEY'],
                                         secret:   ENV['IYZI_SANDBOX_SECRET'],
                                         base_url: ENV['IYZI_SANDBOX_BASE_URL']) }

  context 'successful' do
    cassette 'api_test/successful'
    let(:api_test) { described_class.new(config: config) }

    it 'gets api status' do
      response = api_test.response
      expect(response['status']).to eq('success')
      expect(response['locale']).to eq('tr')
      expect(response['system_time']).not_to be_nil
    end
  end

  context 'failure' do
    cassette 'api_test/failure'
    let(:api_test) { described_class.new(config: config) }
    it 'gets api status' do
      response = api_test.response
      expect(response['status']).to eq('failure')
      expect(response['locale']).to eq('tr')
      expect(response['system_time']).not_to be_nil
    end
  end
end
