require 'spec_helper'

describe Iyzi do
  it 'has a version number' do
    expect(Iyzi::VERSION).not_to be nil
  end

  describe '#configure' do
    let(:config) { Iyzi.configuration }

    context 'default configs' do
      it 'sets default params' do
        expect(config.base_url).to eq(Iyzi::Configuration::BASE_URL)
        expect(config.api_key).to be_nil
        expect(config.secret).to be_nil
      end
    end

    context 'custom configs' do
      before do
        Iyzi.configure do |config|
          config.base_url = 'https://api.iyzipay.com/'
          config.api_key  = 'IYZICO_API_KEY'
          config.secret   = 'IYZICO_SECRET'
        end
      end

      it 'sets custom params' do
        expect(config.base_url).to eq('https://api.iyzipay.com/')
        expect(config.api_key).to eq('IYZICO_API_KEY')
        expect(config.secret).to eq('IYZICO_SECRET')
      end
    end
  end

  describe '#reset' do
    let(:config) { Iyzi.configuration }

    before do
      Iyzi.configure do |config|
        config.base_url = 'not_valid_url'
        config.api_key  = 'another_api_key'
        config.secret   = 'secret'
      end
    end

    it 'resets configs' do
      Iyzi.reset
      expect(config.base_url).to eq(Iyzi::Configuration::BASE_URL)
      expect(config.api_key).to be_nil
      expect(config.secret).to be_nil
    end
  end
end
