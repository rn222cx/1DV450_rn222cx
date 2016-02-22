class User < ActiveRecord::Base
  has_many :stories, dependent: :destroy # remove users stories when delete, same as cascade
  has_many :domains, dependent: :destroy

  before_create :generate_authentication_token

  before_save { self.username = username.downcase }
  validates :username,
            length: { maximum: 20, minimum: 2 }

  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, 
             presence: true,
             length: { maximum: 50 },
             format: { with: VALID_EMAIL_REGEX },
             uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 3 }, allow_nil: true


  # Make sure password is given when update user
  cattr_reader :current_password
  def update_with_password(user_params)
    current_password = user_params.delete(:current_password)

    if self.authenticate(current_password)
      self.update(user_params)
      true
    else
      self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
      false
    end
  end

  # generate a token
  def generate_authentication_token
    loop do
      self.authentication_token = SecureRandom.base64(64)
      break unless User.find_by(authentication_token: authentication_token)
    end
  end

end
