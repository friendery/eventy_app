class Event < ActiveRecord::Base
  dragonfly_accessor :image
  belongs_to :user
  has_many :eventjoinings, dependent: :destroy
  default_scope -> { order('created_at DESC') }
  validates :description, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :user_id, presence: true
  
  def join?(join_user)
    eventjoinings.find_by(user_id: join_user.id)
  end
  
  def join!(join_user)
    eventjoinings.create!(user_id: join_user.id)
  end
  
  def unjoin!(join_user)
    eventjoinings.find_by(user_id: join_user.id).destroy
  end
  
  def self.search(search)
    search_condition = "%" + search.downcase + "%"
    find(:all, :conditions => ['lower(title) LIKE ? OR lower(description) LIKE ?', search_condition, search_condition])
  end
end
