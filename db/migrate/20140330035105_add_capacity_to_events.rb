class AddCapacityToEvents < ActiveRecord::Migration
  def change
    add_column :events, :capacity, :integer, default: 0
  end
end
