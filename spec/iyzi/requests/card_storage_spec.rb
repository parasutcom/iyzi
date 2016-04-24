require 'spec_helper'

describe Iyzi::Requests::CardStorage do
  before { stub_random_string }
  let(:config) { Iyzi::Configuration.new(api_key: 'x', secret: 'x') }

  context '#add' do
    let(:params) do
      {
        locale:          'tr',
        conversation_id: '123',
        email:           'email@email.com',
        external_id:     '321',
        card:            {
          card_alias:       'used in pardev',
          card_holder_name: 'John Doe',
          card_number:      '5528790000000008',
          expire_month:     '12',
          expire_year:      '2030'
        }
      }
    end

    context 'successful response' do
      cassette 'card_storage_add_successful'
      let(:card_request) { described_class.add(params.merge(config: config)) }

      it 'stores credit card number' do
        response = card_request.response
        expect(response['status']).to eq('success')
        expect(response['locale']).to eq('tr')
        expect(response['conversation_id']).to eq(params[:conversation_id])
        expect(response['external_id']).to eq(params[:external_id])
        expect(response['email']).to eq(params[:email])
        expect(response['card_alias']).to eq(params[:card][:card_alias])
        expect(response['bin_number']).to eq(params[:card][:card_number][0...6])
        expect(response['card_type']).to eq('CREDIT_CARD')
        expect(response['card_association']).to eq('MASTER_CARD')
        expect(response['card_family']).to eq('Paraf')
        expect(response['card_bank_code']).to eq(12)
        expect(response['card_bank_name']).to eq('Halk Bankası')
        expect(response['card_token']).not_to be_nil
        expect(response['card_user_key']).not_to be_nil
      end
    end

    context 'failed response' do
      context 'missing card number' do
        cassette 'card_storage_add_missing_card'
        let(:card_request) { described_class.add(email: 'john@doe.com', config: config)}

        it 'returns fail' do
          response = card_request.response
          expect(response['status']).to eq('failure')
          expect(response['error_code']).to eq('3003')
          expect(response['error_message']).to eq('card bilgisi gönderilmesi zorunludur')
          expect(response['email']).to eq('john@doe.com')
        end
      end

      context 'wrong card number' do
        cassette 'card_storage_add_wrong_card'
        let(:params) do
          {
            email: 'john@doe.com',
            card:  {
              card_holder_name: 'John Doe',
              card_number:      '411111',
              expire_month:     '12',
              expire_year:      '2030'
            }
          }
        end
        let(:card_request) { described_class.add(params.merge(config: config)) }

        it 'returns fail' do
          response = card_request.response
          expect(response['status']).to eq('failure')
          expect(response['error_code']).to eq('12')
          expect(response['error_message']).to eq('Kart numarası geçersizdir')
          expect(response['email']).to eq(params[:email])
        end
      end
    end
  end

  context 'delete' do
    let(:params) { { card_token: 'uYPntt0W4QZ8pFm6afLXCvWKjI8=', card_user_key: 'hK13yPTT0DPgs57+Y0lkfuDs1dc=' } }
    let(:delete_request) { described_class.delete(params.merge(config: config)) }

    context 'successful response' do
      cassette 'card_storage_delete_successful'

      it 'deletes stored card' do
        expect(delete_request.response['status']).to eq('success')
      end
    end

    context 'failed response' do
      cassette 'card_storage_delete_card_not_found'
      let(:delete_request) { described_class.delete(params.merge(config: config)) }

      it 'returns fail' do
        response = delete_request.response
        expect(response['status']).to eq('failure')
        expect(response['error_code']).to eq('3006')
        expect(response['error_message']).to eq('cardToken bulunamadı')
      end
    end
  end

  context 'list' do
    context 'successful' do
      cassette 'card_storage_list_successful'
      let(:params) { { card_user_key: '74mARIxf2Z31VnJsdd/AeTgYyAY=' } }
      let(:list_request) { described_class.list(params.merge(config: config)) }

      it 'returns stored cards' do
        response = list_request.response
        expect(response['status']).to eq('success')
        expect(response['card_user_key']).to eq(params[:card_user_key])
        expect(response['card_details']).to be_kind_of(Array)
        card_detail = response['card_details'][0]
        expect(card_detail['card_token']).not_to be_nil
        expect(card_detail['bin_number']).to eq('552879')
        expect(card_detail['card_type']).to eq('CREDIT_CARD')
        expect(card_detail['card_association']).to eq('MASTER_CARD')
        expect(card_detail['card_family']).to eq('Paraf')
        expect(card_detail['card_bank_code']).to eq(12)
        expect(card_detail['card_bank_name']).to eq('Halk Bankası')
      end
    end

    context 'failure' do
      cassette 'card_storage_list_user_not_found'
      let(:params) { { card_user_key: 'XXXX' } }
      let(:list_request) { described_class.list(params.merge(config: config)) }

      it 'returns failure' do
        response = list_request.response
        expect(response['status']).to eq('failure')
        expect(response['card_user_key']).to eq(params[:card_user_key])
        expect(response['error_code']).to eq('3005')
        expect(response['error_message']).to eq('cardUserKey bulunamadı')
      end
    end
  end
end
