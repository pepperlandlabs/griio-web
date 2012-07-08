class FeedItem
  include Mongoid::Document
  include Mongoid::Timestamps

  field :viewed, type: Boolean, default: false

  belongs_to :user
  belongs_to :video

  index({ user_id: 1, video_id: 1 }, { unique: true })
  index({ user_id: 1, viewed: 1 })

  validates_uniqueness_of :video_id, scope: :user_id
end
