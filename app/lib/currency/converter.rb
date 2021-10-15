class Currency
  class Converter
    Error = Class.new(StandardError)
    FromCurrencyNotFoundError = Class.new(Error)
    ToCurrencyNotFoundError = Class.new(Error)
    ZeroAmountError = Class.new(Error)

    attr_reader :params

    def initialize(params)
      @params = params
    end

    def perform
      {
        from: from_currency.symbol,
        to: to_currency.symbol,
        amount: amount.to_f,
        result: (amount * to_currency.rate / from_currency.rate).to_f,
        timestamp: timestamp
      }
    end

    private

    def from_currency
      @from_currency ||= Currency.find_by!(symbol: params[:from])
    rescue
      raise FromCurrencyNotFoundError, 'From currency not found'
    end

    def to_currency
      to_currency ||= Currency.find_by!(symbol: params[:to])
    rescue
      raise ToCurrencyNotFoundError, 'To currency not found'
    end

    def amount
      @amount ||= begin
                    decimal_amount = params[:amount].to_d
                    raise ZeroAmountError, 'Zero amount' if decimal_amount.zero?
                    decimal_amount
                  end
    end

    def timestamp
      from_currency.updated_at.to_i
    end
  end
end
