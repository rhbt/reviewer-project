class User < ActiveRecord::Base
  attr_accessor :remember_token
  
  has_many :reviews
  has_many :comments, dependent: :destroy
  has_many :stickied_reviews, foreign_key: "user_id", dependent: :destroy
  has_many :saved_reviews, through: :stickied_reviews,  source: :review
    
  validates :username, presence: true, length: { minimum: 3, maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                  format: { with: VALID_EMAIL_REGEX }, 
                  uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  before_create :set_times
  before_save :downcase_email
  
  has_secure_password 

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
    
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  private 
    
    def set_times
      self.last_comment = 60.seconds.ago
      self.last_review = Time.zone.now
    end
    
    def downcase_email
      self.email = email.downcase
    end
      
end
