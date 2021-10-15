require 'rails_helper'

describe ConvertationsController do
  describe '/convert' do
    before do
      Project.create(api_key: 'secret')
      Currency.create(symbol: 'EUR', rate: 1)
      Currency.create(symbol: 'USD', rate: 1.5)
    end

    context 'when params are valid' do
      it 'should convert' do
        get '/convert', params: { from: 'EUR', to: 'USD', amount: 2 }, headers: { 'Authorization' => 'Token secret' }
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['result']).to eq(3)
      end
    end

    context 'when params are not valid' do
      it 'should return error' do
        post '/convert', params: { from: 'EUR', to: 'RUB', amount: 2 }, headers: { 'Authorization' => 'Token secret' }
        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['error']).to eq('To currency not found')
      end
    end

    context 'when Authorization header is missing' do
      it 'should respond with 401 status' do
        post '/convert'
        expect(response.status).to eq(401)
      end
    end

    context 'when api key is invalid' do
      it 'should respond with 401 status' do
        get '/convert', headers: { 'Authorization' => 'Token invalid' }
        expect(response.status).to eq(401)
      end
    end
  end
end
