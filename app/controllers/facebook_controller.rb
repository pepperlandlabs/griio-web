class FacebookController < ApplicationController
  before_filter :get_oauth

  def index
    redirect_to @oauth.url_for_oauth_code
  end

  def callback
    access_token = @oauth.get_access_token(params[:code])
    @graph = Koala::Facebook::API.new(access_token)

    profile = @graph.get_object('me')
    if user = User.where(facebook_id: profile['id']).one
      unless user.facebook_access_token.eql?(access_token)
        user.facebook_access_token = access_token
        user.save
      end
      session[:user_id] = user.id.to_s
      redirect_to root_path, notice: "You are logged in as #{user.username}!"
    else
      session[:facebook_access_token] = access_token
      session[:facebook_id] = profile['id']
      session[:name] = profile['name']
      session[:username] = profile['username']
      redirect_to new_user_path
    end
  end

  private
  def get_oauth
    @oauth = Koala::Facebook::OAuth.new(
      '397586540283131',
      'dfe450355847f848006e44a55045149a',
      facebook_callback_url
    )
  end
end
