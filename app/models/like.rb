class Like
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :video

  field :seconds_into_video, type: Integer

  index({ user_id: 1, video_id: 1 }, { unique: true })
  index({ video_id: 1 })

  validates_uniqueness_of :video_id, scope: :user_id
end
