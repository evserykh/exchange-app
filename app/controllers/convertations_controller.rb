class ConvertationsController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  rescue_from Currency::Converter::Error, with: :render_error

  def convert
    converter = Currency::Converter.new(params)
    render json: converter.perform
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |api_key, _options|
      Project.find_by(api_key: api_key)
    end
  end

  def render_error(error)
    render json: { error: error.message }, status: 422
  end
end
