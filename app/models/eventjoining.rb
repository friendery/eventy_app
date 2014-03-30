class Eventjoining < ActiveRecord::Base
    belongs_to :user, class_name: "User"
    belongs_to :event, class_name: "Event"
    default_scope -> { order('updated_at DESC') }
    validates :user_id, presence: true
    validates :event_id, presence: true
end
