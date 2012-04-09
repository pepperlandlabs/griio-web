class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate

  protected
  def authenticate
    unless Rails.env.development?
      authenticate_or_request_with_http_basic do |username, password|
        username == "griio" && password == "lo90p;"
      end
    end
  end
end
