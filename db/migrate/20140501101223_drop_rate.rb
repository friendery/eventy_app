class DropRate < ActiveRecord::Migration
  def change
    remove_column :users, :rate
  end
end
