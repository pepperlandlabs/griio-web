class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :username, type: String
  field :email, type: String
  field :facebook_id, type: String
  field :facebook_access_token, type: String

  has_many :likes
  has_many :feed_items

  index({ facebook_id: 1 }, { unique: true })

  validates_uniqueness_of :email

  after_create { |user| FacebookWorker.perform_async(user.id) }

  def facebook_graph
    @facebook_graph ||= Koala::Facebook::API.new(self.facebook_access_token)
  end
end
