class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :username, type: String
  field :email, type: String
  field :facebook_id, type: String
  field :facebook_access_token, type: String

  has_many :likes

  index({ facebook_id: 1 }, { unique: true })

  validates_uniqueness_of :email

  def facebook_graph
    @facebook_graph ||= Koala::Facebook::API.new(self.facebook_access_token)
  end

  def extract_facebook_network
    friends = self.facebook_graph.get_connections('me', 'friends')
    friend_ids = friends.collect { |f| f['id'] }
    friend_ids.push('me').each do |fb_user_id|
      self.extract_facebook_videos(fb_user_id)
    end
  end

  def extract_facebook_videos(facebook_user_id = 'me')
    feed = self.facebook_graph.get_connections(facebook_user_id, 'feed')
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

        self.likes.create(video_id: video.id) if facebook_user_id.eql?('me')
      end
    end
  end
end
