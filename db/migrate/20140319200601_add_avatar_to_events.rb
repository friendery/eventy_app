class AddAvatarToEvents < ActiveRecord::Migration
  def change
    remove_column :events, :avatar_file_name
    remove_column :events, :avatar_content_type
    remove_column :events, :avatar_file_size
    remove_column :events, :avatar_updated_at
    
    add_column :events, :avatar, :string
  end
end
