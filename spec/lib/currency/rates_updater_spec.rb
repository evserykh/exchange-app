require 'rails_helper'

describe Currency::RatesUpdater do
  describe '#perform' do
    before do
      allow_any_instance_of(Currency::RatesUpdater).to receive(:latest_rates).and_return(
        {"success"=>true, "timestamp"=>1634226903, "base"=>"EUR", "date"=>"2021-10-14", "rates"=>{"USD"=>1.15905, "EUR"=>1}}
      )
    end

    context 'when there are no currencies yet' do
      before { Currency::RatesUpdater.new.perform }

      it 'should create default rates' do
        expect(Currency.count).to eq(2)
      end

      it 'should set rate' do
        expect(Currency.find_by(symbol: 'USD').rate).to eq(1.15905)
      end

      it 'should set updated_at' do
        expect(Currency.find_by(symbol: 'EUR').updated_at).to eq(Time.at(1634226903))
      end
    end

    context 'when there are already currencies' do
      before { Currency.create!(symbol: 'USD') }
      before { Currency::RatesUpdater.new.perform }

      it 'should not create rates' do
        expect(Currency.count).to eq(1)
      end

      it 'should update rate' do
        expect(Currency.first.rate).to eq(1.15905)
      end

      it 'should set updated_at' do
        expect(Currency.first.updated_at).to eq(Time.at(1634226903))
      end
    end
  end
end
