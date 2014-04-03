class RemoveCoordinatorFromEvents < ActiveRecord::Migration
  def change
  	remove_column :events, :lat
  	remove_column :events, :lng
  end
end
