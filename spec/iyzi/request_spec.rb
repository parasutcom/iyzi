require 'spec_helper'

describe Iyzi::Request do
  before { stub_config }
  let(:config) { Iyzi.configuration }

  describe '#initialize' do
    it 'initializes request object' do
      request = described_class.new('post', '/path/to/request', locale: 'en', conversation_id: '123')
      expect(request.method).to eq('post')
      expect(request.path).to eq('/path/to/request')
      expect(request.locale).to eq('en')
      expect(request.conversation_id).to eq('123')
    end
  end

  describe '#connection' do
    let(:request) { described_class.new('post', '/path') }
    it 'returns connection' do
      connection = request.connection
      expect(connection).to be_kind_of(Faraday::Connection)
      expect(connection.url_prefix.to_s).to eq(config.base_url)
    end
  end

  describe '#headers' do
    let(:digest) { 'BXwJ+miJyQ88NLQJB1/FzWZ6he8=' }
    let(:auth_header_string) { "IYZWS IYZICO_API_KEY:#{digest}" }
    let(:pki) { 'pki' }
    let(:random_string) { 'random_string' }
    let(:request) { described_class.new('post', '/path', { config: config }) }

    before do
      # stub random string
      allow_any_instance_of(described_class).to receive(:secure_random_string)
        .and_return(random_string)
      # stub pki
      allow_any_instance_of(described_class).to receive(:to_pki)
        .and_return(pki)
    end

    it 'returns header hash' do
      expected = {
        'Authorization' => auth_header_string,
        'x-iyzi-rnd'    => random_string
      }
      expect(request.auth_headers).to eq(expected)
    end

    it '#auth_header_string' do
      expect(request.auth_header_string).to eq(auth_header_string)
    end

    it '#request_hash_digest' do
      expect(request.request_hash_digest).to eq(digest)
    end

    it '#params_will_be_hashed' do
      expected = config.api_key + random_string + config.secret + pki
      expect(request.params_will_be_hashed).to eq(expected)
    end
  end

  it 'generates secure_random_string' do
    str = described_class.new('post', '/path').secure_random_string
    expect(str).not_to be_nil
    expect(str.size).to eq(8)
  end
end
