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

  def embed_url
    case source
    when :youtube
      "http://www.youtube.com/embed/#{self.source_id}?autoplay=1&modestbranding=1&amp;showinfo=0&amp;wmode=opaque"
    end
  end

  def source_id
    case source
    when :youtube
      self.href.scan(/v=([\w-]+)&*/).flatten.first
    end
  end
end
