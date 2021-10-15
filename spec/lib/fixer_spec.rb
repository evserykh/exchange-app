require 'rails_helper'

describe Fixer do
  describe '#latest' do
    before { allow(ENV).to receive(:[]).with('FIXER_ACCESS_KEY').and_return('access_key') }

    context 'when response is success' do
      before do
        stub_request(:get, "http://data.fixer.io/latest?access_key=#{ENV['FIXER_ACCESS_KEY']}").to_return(
          body: '{"success":true,"timestamp":1634226903,"base":"EUR","date":"2021-10-14","rates":{"USD":1.15905,"EUR":1}}'
        )
      end

      it 'should return latest rates' do
        expect(Fixer.new.latest['rates']['EUR']).to eq(1)
        expect(Fixer.new.latest['rates']['USD']).to eq(1.15905)
      end
    end

    context 'when response is not success' do
      before do
        stub_request(:get, "http://data.fixer.io/latest?access_key=#{ENV['FIXER_ACCESS_KEY']}").to_return(
          body: '{"success":false,"error":{"code":105,"type":"base_currency_access_restricted"}}'
        )
      end

      it 'should raise exception' do
        expect { Fixer.new.latest }.to raise_error(Fixer::ApiError)
      end
    end
  end
end
