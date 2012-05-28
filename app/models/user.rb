class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :username, type: String
  field :email, type: String
  field :facebook_id, type: String
  field :facebook_access_token, type: String

  index({ facebook_id: 1 }, { unique: true })

  validates_uniqueness_of :email
end
