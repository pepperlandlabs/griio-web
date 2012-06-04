class Video
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String
  field :source, type: Symbol
  field :href, type: String

  has_many :likes

  index({ href: 1 }, { unique: true })

  validates_uniqueness_of :href
end
