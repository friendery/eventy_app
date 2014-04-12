class AddTimeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :time, :string
  end
end
