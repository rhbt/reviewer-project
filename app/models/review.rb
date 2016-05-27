class Review < ActiveRecord::Base
  require "net/http"
  
  belongs_to :user
  
  validates :url, presence: true
  validate :url, :valid_url
  validates :content, presence: true, length: { minimum: 10 }

private

  def valid_url
    begin
      if (self.url =~ /\Ahttps:\/\//)
        self.url = "http" + url[5..-1]
      elsif (self.url !~ /\Ahttp:\/\//)
        self.url = "http://#{url}"
      end
      
      review_url = URI.parse(url)
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
