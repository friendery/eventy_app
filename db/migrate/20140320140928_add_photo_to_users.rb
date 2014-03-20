class AddPhotoToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :avatar
    add_column :users, :photo, :string
  end
end
