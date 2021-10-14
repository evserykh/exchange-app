class UpdateRatesWorker
  include Sidekiq::Worker

  def perform
    Currency::RatesUpdater.new.perform
  end
end
