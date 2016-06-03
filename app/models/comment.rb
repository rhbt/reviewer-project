class Comment < ActiveRecord::Base
  belongs_to :review
  belongs_to :user
  validates :user_id, presence: true
  validates :review_id, presence: true
  validates :content, presence: true, length: { minimum: 10 }
  
  
end
