class FacebookWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    friends = user.facebook_graph.get_connections('me', 'friends')
    friend_ids = friends.collect { |f| f['id'] }
    friend_ids.push('me').each do |fb_user_id|
      extract_facebook_videos(user, fb_user_id)
    end
  end

  def extract_facebook_videos(user, facebook_user_id = 'me')
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

        user.likes.create(video_id: video.id) if facebook_user_id.eql?('me')
      end
    end
  end
end
