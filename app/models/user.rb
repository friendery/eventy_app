class User < ActiveRecord::Base
  has_many :events, dependent: :destroy
  has_many :eventjoinings, dependent: :destroy
  has_many :joinedevents, :through => :eventjoinings, :source => 'event'
  
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  mount_uploader :photo, AvatarUploader
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def friend?(friend_id)
    #friendships.find_by(friend_id: friend_id)||inverse_friendships.find_by(user_id: friend_id)
    # Status: 3 status for friendship in total and uncomment following codes once add status into
    # friendship table
    if a = friendships.find_by(friend_id: friend_id)||inverse_friendships.find_by(user_id: friend_id)
      b = a.status
    else
      b = 'not_friend'
    end
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
