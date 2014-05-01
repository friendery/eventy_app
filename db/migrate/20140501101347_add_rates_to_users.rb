class AddRatesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rate, :decimal, :precision => 6, :scale => 3
  end
end
