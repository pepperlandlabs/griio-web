class Web::VideosController < ApplicationController
  def index
    feed_item = current_user.feed_items.one
    redirect_to web_video_path(feed_item.video) if feed_item
  end

  def show
    @video = Video.find(params[:id])
    @feed_item = current_user.feed_items.unscoped.where(video_id: @video.id).one
    current_user.view_video(@video) if current_user
  end
end
