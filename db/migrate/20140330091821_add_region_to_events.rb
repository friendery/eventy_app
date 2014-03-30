class AddRegionToEvents < ActiveRecord::Migration
  def change
    add_column :events, :region, :text
  end
end
