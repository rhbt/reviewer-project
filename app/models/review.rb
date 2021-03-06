class Review < ActiveRecord::Base
  belongs_to :user
  
  has_many :stickied_reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  before_validation :format_url
  validates :user_id, presence: true
  validates :url, presence: true, uniqueness: { case_sensitive: false }
  # validate :url, :valid_url
  validates :content, presence: true, length: { minimum: 10 }
  validates :rating, presence: true, inclusion: 1..5

  
  
private
#downcase
  def format_url 
    self.url = url.strip
    if self.url =~ /\Ahttps?:\/\//
      pos = url =~ /:\/\//
      self.url = url[pos+3..-1].downcase
    end
    url 
  end
    
  def valid_url
    if self.url =~ /https?:\/\/[\S]+/
      return
    else
      errors.add(:url, "is not valid")
    end
      
    # begin
    #   if (self.url == "www.test.com")
    #     return
    #   end
      
    #   review_url = URI.parse("http://"+url)
    #   req = Net::HTTP.new(review_url.host, review_url.port)
    #   res = req.request_get(review_url.path)
    #   if res.code != "200"
    #     errors.add(:url, "is not valid")
    #   end
      
    # rescue
    #   errors.add(:url, "is not valid")
    # end
  end

end

