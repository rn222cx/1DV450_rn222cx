class User < ActiveRecord::Base
  has_many :stories, dependent: :destroy # remove users stories when delete, same as cascade
  has_many :domains, dependent: :destroy
  
  validates :username, presence: true
  
  before_save { self.email = email.downcase }       
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, 
             presence: true,
             length: { maximum: 50 },
             format: { with: VALID_EMAIL_REGEX },
             uniqueness: { case_sensitive: false }
              
  has_secure_password
  validates :password_digest, length: { minimum: 3 }
               
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end        
end
