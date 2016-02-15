class Review < ActiveRecord::Base
  belongs_to :user
  
  validates :url, presence: true
  validates :content, presence: true
  
end
