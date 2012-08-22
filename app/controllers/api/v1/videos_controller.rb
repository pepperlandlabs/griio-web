class Api::V1::VideosController < ApplicationController
  def index
    feed_item = current_user.feed_items.one
    redirect_to web_video_path(feed_item.video) if feed_item
  end

  def show
    @video = Video.find(params[:id])
    current_user.view_video(@video) if current_user
  end
end
