class Video
  include Mongoid::Document
  include Mongoid::Timestamps

  GOOGLE_DEV_KEY = 'AI39si5eMzdODzsxlGRTPnnANZihScH7IyXfseK3CJjfKZpVPglHh0Qcqz6jRB58w_ySLJ6wjX6zZ51ddDTrlfbwUuaPRAGPjQ'

  field :title, type: String
  field :description, type: String
  field :source, type: Symbol
  field :href, type: String
  field :duration, type: Integer
  field :categories, type: Array
  field :keywords, type: Array

  has_many :likes

  index({ href: 1 }, { unique: true })

  validates_uniqueness_of :href

  before_create :get_meta_data

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

  def thumbnail
    case source
    when :youtube
      "http://i.ytimg.com/vi/#{self.source_id}/hqdefault.jpg"
    end
  end

  private

  def get_meta_data
    case source
    when :youtube
      begin
        client = YouTubeIt::Client.new(dev_key: GOOGLE_DEV_KEY)
        video = client.video_by(self.source_id)
        self.duration = video.duration
        self.categories = video.categories.collect { |cat| cat.label }
        self.keywords = video.keywords
      rescue Exception => e
      end
    end
  end
end
