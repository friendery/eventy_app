class AddAvatarToEvents < ActiveRecord::Migration
  def change
  end
  
  def self.up
    add_attachment :users, :avatar
  end

  def self.down
    remove_attachment :users, :avatar
  end
end
