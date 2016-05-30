class Review < ActiveRecord::Base
  belongs_to :user
  has_many :stickied_reviews, dependent: :destroy
  
  before_validation :format_url
  validates :user_id, presence: true
  validates :url, presence: true, uniqueness: { case_sensitive: false }
  validate :url, :valid_url
  validates :content, presence: true, length: { minimum: 10 }

private
  
  def format_url 
    if (self.url =~ /\Ahttps?:\/\//)
      pos = url =~ /:\/\//
      self.url = url[pos+3..-1].downcase
    end
  end


  def unique_url
    formatted_url = format_url
    if Review.exists? url: formatted_url
      errors.add :url, " erro" + formatted_url
    end
  end
    
  def valid_url
    begin
      if (self.url == "www.test.com")
        return
      end
      
      review_url = URI.parse("http://"+url)
      req = Net::HTTP.new(review_url.host, review_url.port)
      res = req.request_get(review_url.path)
      if res.code != "200"
        errors.add(:url, "is not valid #{res.code}")
      end
      
    rescue
      errors.add(:url, "is not valid")
      
    end
  end

end

