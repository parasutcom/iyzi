require 'spec_helper'

describe Iyzi::Configuration do
  it 'assigns api_key and secret' do
    config = described_class.new(api_key: '123', secret: '456')
    expect(config.api_key).to eq('123')
    expect(config.secret).to eq('456')
  end

  context '#validate' do
    let(:config) { Iyzi::Configuration.new(api_key: 'api_key', secret: 'secret') }
    let(:not_valid) { Iyzi::Configuration.new }
    it 'validates config' do
      expect(config.valid?).to be_truthy
      expect(not_valid.valid?).to be_falsey
    end

    it 'returns missing configuration keys' do
      expect(not_valid.missing_configs).to eq([:api_key, :secret])
      expect(config.missing_configs).to eq([])
    end

    it 'throws error' do
      expect { not_valid.validate }.to raise_error('Missing configuration keys: api_key, secret')
    end
  end
end
