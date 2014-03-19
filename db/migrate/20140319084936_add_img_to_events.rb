class AddImgToEvents < ActiveRecord::Migration
  def change
    add_column :events, :image_uid,  :string
    add_column :events, :image_name, :string
  end
end
