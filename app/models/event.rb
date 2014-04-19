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
  validates :time,        presence: true
  validates :region,      presence: true
  
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
    @a = eventjoinings.create!(user_id: join_user.id, status: join_status)
    @a.id
  end
  
  def unjoin!(join_user)
    eventjoinings.find_by(user_id: join_user.id).destroy
  end
  
  def self.search(what, date, time_period, region)
    what_condition = what.downcase
    event = Event.all
    event = event.where("lower(title) LIKE ? OR lower(description) LIKE ?", 
                        "%#{what_condition}%", "%#{what_condition}%") unless what.blank?
    event = event.where("date = ?", "#{date}") unless date.blank?
    event = event.where("region = ?", "#{region}") unless region.blank?
    if time_period == "Morning"
      timeperiod_array = ["Midnight", "Morning", "Noon"]
    elsif time_period == "Afternoon"
      timeperiod_array = ["Evening", "Afternoon", "Noon"]
    else
      timeperiod_array = ["Evening", "Night", "Midnight"]
    end
    event = event.where("time_period in (?)", timeperiod_array) unless time_period.blank?
    event
  end
  
  def convertTime
    if time >= "03:00" && time < "11:30"
      period = "Morning"
    elsif time >= "11:30" && time < "13:00"
      period = "Noon"
    elsif time >= "13:00" && time < "18:30"
      period = "Afternoon"
    elsif time >= "18:30" && time < "19:30"
      period = "Evening"
    elsif time >= "19:30" && time <= "23:59"
      period = "Night"
    else
      period = "Midnight"
    end
    self.update_attribute(:time_period, period)
  end
      
  
  def average_rate
    if rates.size > 0
      rates.sum(:score) * 1.0 / rates.size
    else
      0
    end
  end
end
