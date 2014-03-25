class CreateFriendships < ActiveRecord::Migration
  def change
    drop_table :friendships
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id

      t.timestamps
    end
  end
end
