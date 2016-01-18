class User < ActiveRecord::Base
  has_many :stories
  
  has_secure_password
  validates :password_digest, length: { minimum: 3 }
  
  
#  validates :email,
#            :presence => {:message => "You have to enter a email"},
#            uniqueness: true
            
#  validates_format_of :email, :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
#                      :presence => {:message => "Wrong format on email"}
               
  before_save { self.email = email.downcase }       
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, 
             presence: true,
             length: { maximum: 50 },
             format: { with: VALID_EMAIL_REGEX },
             uniqueness: { case_sensitive: false }
              
  
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end        
end
