require 'spec_helper'

describe Iyzi::Requests::ApiTest do
  let(:config) { Iyzi::Configuration.new(api_key: 'x', secret: 'x') }

  context 'successful' do
    cassette 'successful_api_test'
    let(:api_test) { described_class.new(config: config) }

    it 'gets api status' do
      response = api_test.response
      expect(response['status']).to eq('success')
      expect(response['locale']).to eq('tr')
      expect(response['system_time']).to eq(1460586307051)
    end
  end

  context 'failure' do
    cassette 'failed_api_test'
    let(:api_test) { described_class.new(config: config) }
    skip 'gets api status'
  end
end
