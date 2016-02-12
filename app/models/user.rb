class User < ActiveRecord::Base
    before_save :downcase_email
    
    validates :username, presence: true, length: { minimum: 3, maximum: 30 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
    has_secure_password 
    validates :password, presence: true, length: { minimum: 6 }
        
    private 
    
      def downcase_email
          self.email = email.downcase
      end
      
end
