class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate

  protected
  def authenticate
    unless Rails.env.development? || Rails.env.test?
      authenticate_or_request_with_http_basic do |username, password|
        username == "griio" && password == "lo90p;"
      end
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
