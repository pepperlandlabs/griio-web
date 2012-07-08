class VideosController < ApplicationController
  def index
    feed_item = current_user.feed_items.one
    redirect_to feed_item.video
  end

  def show
    @video = Video.find(params[:id])
    current_user.view_video(@video) if current_user
  end
end
