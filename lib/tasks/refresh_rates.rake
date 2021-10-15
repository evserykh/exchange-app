desc 'Update rates'
task update_rates: :environment do
  Currency::RatesUpdater.new.perform
  Currency.find_each { |currency| puts "Got #{currency.symbol} with rate #{currency.rate}" }
end
