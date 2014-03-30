class AddCapacityToEvents < ActiveRecord::Migration
  def change
    add_column :events, :capacity, :integer
  end
end
