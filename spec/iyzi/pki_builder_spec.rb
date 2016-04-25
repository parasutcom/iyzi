require 'spec_helper'

describe Iyzi::PkiBuilder do
  let(:builder) { described_class.new }

  it 'accepts params hash' do
    params = { price: 18.954, locale: 'tr' }
    builder = described_class.new(params)
    expect(builder.params[:price]).to eq(params[:price].to_s)
    expect(builder.params[:locale]).to eq(params[:locale])
  end

  context 'add methods' do
    describe '#add' do
      it 'adds key, value to params' do
        builder.add('basketId', 123456)
        expect(builder.params['basketId']).to eq('123456')
      end
    end

    describe '#add_price' do
      it 'adds price to params' do
        builder.add_price('price', 12.3456)
        expect(builder.params['price']).to eq('12.35')
      end
    end

    describe '#add_array' do
      it 'adds array to params' do
        builder.add_array('basketItems', [1, 2, 3, 4, 5])
        expect(builder.params['basketItems']).to eq('[1, 2, 3, 4, 5]')
      end
    end

    describe '#add_date' do
      it 'adds date to params' do
        date = '24-04-2016'
        expected = Date.parse(date).strftime('%Y-%m-%d %H:%M:%S')
        builder.add_date('date', date)
        expect(builder.params['date']).to eq(expected)
      end
    end

    describe '#add_buyer' do
      it 'adds buyer to params' do
        expect_any_instance_of(Iyzi::PkiBuilders::Buyer).to receive(:request_string).once.and_return('buyer_string')
        builder.add_buyer('buyer', name: 'Genc')
        expect(builder.params['buyer']).to eq('buyer_string')
      end
    end

    describe '#add_address' do
      it 'adds address to params' do
        expect_any_instance_of(Iyzi::PkiBuilders::Address).to receive(:request_string).once.and_return('address_string')
        builder.add_address('address', address: 'Tomtom')
        expect(builder.params['address']).to eq('address_string')
      end
    end

    describe '#add_basket_items' do
      it 'adds basket items to params' do
        expect_any_instance_of(Iyzi::PkiBuilders::BasketItems).to receive(:request_array).once.and_return(['item_string'])
        builder.add_basket_items('items', [{ price: 5 }])
        expect(builder.params['items']).to eq('[item_string]')
      end
    end

    describe '#add_payment_card' do
      it 'adds payment card to params' do
        expect_any_instance_of(Iyzi::PkiBuilders::PaymentCard).to receive(:request_string).once.and_return('card_string')
        builder.add_payment_card('card', card_token: 'test')
        expect(builder.params['card']).to eq('card_string')
      end
    end

    describe '#add_store_card' do
      it 'adds store card to params' do
        expect_any_instance_of(Iyzi::PkiBuilders::StoreCard).to receive(:request_string).once.and_return('card_string')
        builder.add_store_card('card', card_token: 'test')
        expect(builder.params['card']).to eq('card_string')
      end
    end

  end

  describe '#request_string' do
    before do
      builder.add('basketId', 123_456)
      builder.add_price('price', 12.3456)
      builder.add_array('basketItems', [1, 2, 3, 4, 5])
      builder.add_date('date', '24-04-2016')
      builder.add_buyer('buyer', { 'name' => 'Genc', 'surname' => 'Osman'})
      builder.add_address('address', { 'zipCode' => '00000' })
      builder.add_basket_items('items', [{ 'id' => '0001' }])
    end

    it 'returns request_string' do
      expected = '[basketId=123456,price=12.35,basketItems=[1, 2, 3, 4, 5],date=2016-04-24 00:00:00,buyer=[name=Genc,surname=Osman],address=[zipCode=00000],items=[[id=0001]]]'
      expect(builder.request_string).to eq(expected)
    end
  end

  context 'has locale and conversation_id' do
    let(:locale)          { 'tr' }
    let(:conversation_id) { '123456' }

    it 'returns request string' do
      builder = described_class.new('locale' => locale, 'conversationId' => conversation_id)
      expected = "[locale=#{locale},conversationId=#{conversation_id}]"
      expect(builder.request_string).to eq(expected)
    end
  end
end
