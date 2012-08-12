class Web::HomeController < ApplicationController
  def index
    redirect_to web_videos_path if current_user
  end
end
