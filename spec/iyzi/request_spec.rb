require 'spec_helper'

describe Iyzi::Request do
  let(:config) { instance_double('Iyzi::Configuration', base_url: 'https://api.iyzi.com', api_key: 'test_key', secret: 'test_secret', validate: true) }
  let(:path) { '/test-path' }
  let(:method) { :post }
  let(:options) { { locale: 'en', currency: 'TRY', custom_param: 'value' } }
  let(:request) { described_class.new(method, path, options.merge(config: config)) }

  before do
    allow(Iyzi).to receive(:configuration).and_return(config)
    allow(Iyzi::Currency).to receive(:find).and_return('TRY')
    allow(SecureRandom).to receive(:urlsafe_base64).and_return('random123')
    allow(Iyzi::Utils).to receive(:hash_to_properties).and_return({ custom_param: 'value' })
    allow(Iyzi::Utils).to receive(:properties_to_hash).and_return({ success: true })
  end

  describe '#initialize' do
    it 'sets the method, path, and options' do
      expect(request.method).to eq(method)
      expect(request.path).to eq(path)
      expect(request.options).to include(locale: 'en', currency: 'TRY', custom_param: 'value')
    end

    it 'defaults locale to "tr" if not provided' do
      options.delete(:locale)
      new_request = described_class.new(method, path, options.merge(config: config))
      expect(new_request.options[:locale]).to eq('tr')
    end

    it 'removes empty string values from options' do
      options[:empty_param] = ''
      new_request = described_class.new(method, path, options.merge(config: config))
      expect(new_request.options).not_to include(:empty_param)
    end

    it 'validates the config if PKI is present' do
      allow_any_instance_of(described_class).to receive(:to_pki).and_return('pki_value')
      expect(config).to receive(:validate)
      described_class.new(method, path, options.merge(config: config))
    end
  end

  describe '#iyzi_options' do
    it 'returns compacted hash of options as properties' do
      expect(request.iyzi_options).to eq(custom_param: 'value')
    end
  end

  describe '#connection' do
    it 'creates a Faraday connection with the correct base URL' do
      connection = request.connection
      expect(connection.url_prefix.to_s.chomp('/')).to eq(config.base_url.chomp('/'))
    end

    it 'adds JSON request and response middleware' do
      expect(Faraday).to receive(:new).with(url: config.base_url).and_yield(double('builder').tap do |builder|
        expect(builder).to receive(:request).with(:json)
        expect(builder).to receive(:response).with(:json, content_type: /\bjson$/)
        expect(builder).to receive(:adapter).with(Faraday.default_adapter)
      end)

      request.connection
    end
  end

  describe '#response' do
    let(:call_response) { instance_double('Faraday::Response', body: { success: true }) }

    before do
      allow(request).to receive(:call).and_return(call_response)
    end

    it 'returns the response as a hash' do
      expect(request.response).to eq(success: true)
    end
  end

  describe '#auth_headers' do
    it 'returns the correct authorization and random headers' do
      expect(request.auth_headers).to eq(
        'Authorization' => request.auth_header_string,
        'x-iyzi-rnd' => 'random123'
      )
    end
  end

  describe '#auth_header_string' do
    it 'generates the correct authorization header string' do
      allow(request).to receive(:encrypted_data).and_return('encrypted123')
      expected_string = "IYZWSv2 #{Base64.strict_encode64('apiKey:test_key&randomKey:random123&signature:encrypted123')}"
      expect(request.auth_header_string).to eq(expected_string)
    end
  end

  describe '#encrypted_data' do
    it 'generates an HMAC-SHA256 hash of the data to encrypt' do
      allow(request).to receive(:data_to_encrypt).and_return('data_to_encrypt')
      expect(request.encrypted_data).to eq(OpenSSL::HMAC.hexdigest('SHA256', 'test_secret', 'data_to_encrypt'))
    end
  end

  describe '#has_pki?' do
    it 'returns true if PKI is present' do
      allow(request).to receive(:pki).and_return('pki_value')
      expect(request.has_pki?).to be(true)
    end

    it 'returns false if PKI is nil or empty' do
      allow(request).to receive(:pki).and_return(nil)
      expect(request.has_pki?).to be(false)
    end
  end

  describe '#secure_random_string' do
    it 'returns a random string of 6 characters' do
      expect(request.secure_random_string).to eq('random123')
    end
  end
end
