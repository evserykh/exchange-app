require 'net/http'

class Fixer
  ApiError = Class.new(StandardError)

  def symbols
    response_for('symbols')
  end

  def latest(params: {})
    response_for('latest', params)
  end

  private

  def access_key
    ENV['FIXER_ACCESS_KEY']
  end

  def base_url
    'http://data.fixer.io/api'
  end

  def url_for(endpoint, params)
    uri = URI.join(base_url, endpoint)
    uri.query = URI.encode_www_form({ access_key: access_key }.merge(params))
    uri
  end

  def response_for(endpoint, params = {})
    response = Net::HTTP.get(url_for(endpoint, params))
    parsed_response = JSON.parse(response)
    raise ApiError, parsed_response['error'] unless parsed_response['success']
    parsed_response
  end
end
