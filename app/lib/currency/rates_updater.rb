class Currency
  class RatesUpdater
    def perform
      available_symbols.each do |symbol|
        currency(symbol).update(rate: rate(symbol), updated_at: updated_at)
      end
    end

    private

    def available_symbols
      existing_symbols.any? ? existing_symbols : default_symbols
    end

    def existing_symbols
      @already_used_symbols ||= Currency.distinct.pluck(:symbol)
    end

    def default_symbols
      %w[EUR USD]
    end

    def base_symbol
      'EUR'
    end

    def fixer
      Fixer.new
    end

    def latest_rates
      @latest_rates ||= begin
                          params = { symbols: available_symbols.join(','), base: base_symbol }
                          fixer.latest(params: params)
                        end
    end

    def rate(symbol)
      latest_rates['rates'][symbol]
    end

    def updated_at
      @updated_at ||= Time.at(latest_rates['timestamp'])
    end

    def currency(symbol)
      Currency.find_or_create_by(symbol: symbol)
    end
  end
end
