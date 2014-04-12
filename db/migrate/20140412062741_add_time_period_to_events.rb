class AddTimePeriodToEvents < ActiveRecord::Migration
  def change
    add_column :events, :time_period, :string
  end
end
