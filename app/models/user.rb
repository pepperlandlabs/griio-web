class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :username, type: String
  field :email, type: String
  field :facebook_id, type: String
  field :facebook_access_token, type: String
  field :auth_token, type: String

  has_many :likes
  has_many :feed_items

  index({ facebook_id: 1 }, { unique: true })

  validates_uniqueness_of :email

  before_create :generate_auth_token
  after_create { |user| FacebookWorker.perform_async(user.id.to_s) }

  def facebook_graph
    @facebook_graph ||= Koala::Facebook::API.new(self.facebook_access_token)
  end

  def view_video(video)
    if feed_item = self.feed_items.unscoped.where(video_id: video.id).one
      feed_item.viewed = true
      feed_item.save
    end
  end

  private

  def generate_auth_token
    self.auth_token = SecureRandom.base64(15).tr('+/=', 'xyz')
  end
end
