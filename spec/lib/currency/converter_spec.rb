require 'rails_helper'

describe Currency::Converter do
  describe '#perform' do
    before do
      Project.create(api_key: 'secret')
      Currency.create(symbol: 'EUR', rate: 1)
      Currency.create(symbol: 'USD', rate: 1.5)
    end

    context 'when params are valid' do
      it 'should return convertation result' do
        convertation = Currency::Converter.new(from: 'EUR', to: 'USD', amount: 2).perform
        expect(convertation[:from]).to eq('EUR')
        expect(convertation[:to]).to eq('USD')
        expect(convertation[:amount]).to eq(2)
        expect(convertation[:result]).to eq(3)
        expect(convertation[:timestamp]).to eq(Currency.first.updated_at.to_i)
      end
    end

    context 'when from is missing' do
      it 'should raise error' do
        expect { Currency::Converter.new(to: 'USD', amount: 2).perform }.to raise_error(Currency::Converter::FromCurrencyNotFoundError)
        expect { Currency::Converter.new(from: 'RUB', to: 'USD', amount: 2).perform }.to raise_error(Currency::Converter::FromCurrencyNotFoundError)
      end
    end

    context 'when to is missing' do
      it 'should raise error' do
        expect { Currency::Converter.new(from: 'USD', amount: 2).perform }.to raise_error(Currency::Converter::ToCurrencyNotFoundError)
        expect { Currency::Converter.new(from: 'USD', to: 'RUB', amount: 2).perform }.to raise_error(Currency::Converter::ToCurrencyNotFoundError)
      end
    end

    context 'when amount equal zero' do
      it 'should raise error' do
        expect { Currency::Converter.new(from: 'USD', to: 'EUR', amount: 0).perform }.to raise_error(Currency::Converter::ZeroAmountError)
        expect { Currency::Converter.new(from: 'USD', to: 'EUR').perform }.to raise_error(Currency::Converter::ZeroAmountError)
      end
    end
  end
end
