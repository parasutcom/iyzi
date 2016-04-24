require 'spec_helper'

describe Iyzi::PkiBuilder do
  it 'accepts params hash' do
    params = { price: 18.954, locale: 'tr' }
    builder = described_class.new(params)
    expect(builder.params).to eq(params)
  end

  describe '#add' do
    let(:builder) { described_class.new }
    it 'adds key, value to params' do
      builder.add('basketId', 123456)
      expect(builder.params['basketId']).to eq('123456')
    end
  end

  describe '#add_price' do
    let(:builder) { described_class.new }
    it 'adds price to params' do
      builder.add_price('price', 12.3456)
      expect(builder.params['price']).to eq('12.35')
    end
  end

  describe '#add_array' do
    let(:builder) { described_class.new }
    it 'adds array to params' do
      builder.add_array('basketItems', [1, 2, 3, 4, 5])
      expect(builder.params['basketItems']).to eq('[1, 2, 3, 4, 5]')
    end
  end

  describe '#request_string' do
    let(:builder) { described_class.new }

    before do
      builder.add('basketId', 123_456)
      builder.add_price('price', 12.3456)
      builder.add_array('basketItems', [1, 2, 3, 4, 5])
    end

    it 'returns request_string' do
      expected = '[basketId=123456,price=12.35,basketItems=[1, 2, 3, 4, 5]]'
      expect(builder.request_string).to eq(expected)
    end
  end

  context 'has locale and conversation_id' do
    let(:locale)          { 'tr' }
    let(:conversation_id) { '123456' }

    it 'returns request string' do
      builder = described_class.new(locale: locale, conversation_id: conversation_id)
      expected = "[locale=#{locale},conversation_id=#{conversation_id}]"
      expect(builder.request_string).to eq(expected)
    end
  end
end
