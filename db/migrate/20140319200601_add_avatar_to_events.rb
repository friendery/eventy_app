class AddAvatarToEvents < ActiveRecord::Migration
  def changeß
    add_column :events, :avatar, :string
  end
end
