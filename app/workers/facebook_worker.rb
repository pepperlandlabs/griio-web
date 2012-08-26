class FacebookWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    friends = user.facebook_graph.get_connections('me', 'friends')
    friends.each do |friend|
      extract_facebook_videos(user, friend['id'], friend['name'])
    end

    extract_facebook_videos(user, 'me')
  end

  def extract_facebook_videos(user, facebook_user_id, name = nil)
    feed = user.facebook_graph.get_connections(facebook_user_id, 'feed')
    feed.each do |item|
      if item['type'].eql?('video')
        case item['link']
        when /youtube/
          source = :youtube
        when /vimeo/
          source = :vimeo
        else
          next
        end

        video = Video.find_or_initialize_by(href: item['link'])
        unless video.persisted?
          video.source = source
          video.title = item['name']
          video.description = item['description']
          video.save
        end

        if facebook_user_id.eql?('me')
          user.likes.create(video_id: video.id)
        else
          user.feed_items.create(
            video_id: video.id,
            facebook_user_id: facebook_user_id,
            facebook_user_name: name
          )
        end
      end
    end
  end
end
