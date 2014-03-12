class Event < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :description, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :user_id, presence: true
end
