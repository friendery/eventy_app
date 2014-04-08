class Event < ActiveRecord::Base
  has_many :eventjoinings, dependent: :destroy
  default_scope -> { order('created_at DESC') }
  
  has_many :comments, dependent: :destroy
  
  has_many :rates, dependent: :destroy
  
  validates :description, presence: true
  validates :title,       presence: true, length: { maximum: 30 }
  validates :user_id,     presence: true
  validates :capacity,    presence: true, numericality: { only_integer: true }
  validates :date,        presence: true
  
  belongs_to :user
  mount_uploader :avatar, PictureUploader
  
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
  
  def self.search(what, date, region, page)
    what_condition = "%" + what.downcase + "%"
    date_condition = "%" + date.downcase + "%"
    
    if region == ""
      paginate :per_page => 30, :page => page,
               :conditions => ['lower(title) LIKE ? OR lower(description) LIKE ?', what_condition, what_condition],
               :order => 'created_at DESC'
    else
      region_condition = "%" + region.downcase + "%"
      paginate :per_page => 30, :page => page,
               :conditions => ['(lower(title) LIKE ? OR lower(description) LIKE ?) AND lower(region) LIKE ?', what_condition, what_condition, region_condition],
               :order => 'created_at DESC'
    end
  end
      
  
  def average_rate
    if rates.size > 0
      rates.sum(:score) * 1.0 / rates.size
    else
      0
    end
  end
end
