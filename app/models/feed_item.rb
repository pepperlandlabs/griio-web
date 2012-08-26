class FeedItem
  include Mongoid::Document
  include Mongoid::Timestamps

  field :viewed, type: Boolean, default: false
  field :facebook_user_id, type: String
  field :facebook_user_name, type: String

  belongs_to :user
  belongs_to :video

  default_scope where(viewed: false)

  index({ user_id: 1, video_id: 1 }, { unique: true })
  index({ user_id: 1, viewed: 1 })

  validates_uniqueness_of :video_id, scope: :user_id

  def facebook_profile_picture_url(type = 'large')
    "http://graph.facebook.com/#{self.facebook_user_id}/picture?type=#{type}"
  end
end
