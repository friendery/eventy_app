class AddStreetToEvents < ActiveRecord::Migration
  def change
    add_column :events, :street, :text
  end
end
