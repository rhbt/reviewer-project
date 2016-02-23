class Review < ActiveRecord::Base
  belongs_to :user
  
  validates :url, presence: true
  validate :url, :valid_url
  validates :content, presence: true, length: { minimum: 10 }

private
  def valid_url
    if url.blank?
      return
    end
    begin
      review_url = URI.parse(url)
      req = Net::HTTP.new(review_url.host, review_url.port)
      res = req.request_head(review_url.path)
      if res.code == "200"
        true
      else
        errors.add(:url, "is not valid")
      end
      
     rescue
      errors.add(:url, "is not valid")
      
    end
  end

end
