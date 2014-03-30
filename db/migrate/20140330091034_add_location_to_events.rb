class AddLocationToEvents < ActiveRecord::Migration
  def change
    add_column :events, :lat, :text
    add_column :events, :lng, :text
    add_column :events, :administrative_area_level_1, :text
  end
end
