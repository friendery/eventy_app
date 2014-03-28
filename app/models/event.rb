class Event < ActiveRecord::Base
  has_many :eventjoinings, dependent: :destroy
  default_scope -> { order('created_at DESC') }
  validates :description, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :user_id, presence: true
  belongs_to :user
  mount_uploader :avatar, AvatarUploader
  
  def join?(join_user)
    if a = eventjoinings.find_by(user_id: join_user.id)
      b = a.status
    else
      b = 'false'
    end
  end
  
  def join!(join_user, join_status)
    eventjoinings.create!(user_id: join_user.id, status: join_status)
  end
  
  def unjoin!(join_user)
    eventjoinings.find_by(user_id: join_user.id).destroy
  end
  
  def self.search(search)
    search_condition = "%" + search.downcase + "%"
    find(:all, :conditions => ['lower(title) LIKE ? OR lower(description) LIKE ?', search_condition, search_condition])
  end
end
