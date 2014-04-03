class AddMarksToRates < ActiveRecord::Migration
  def change
    remove_column :rates, :mark
    add_column :rates, :mark, :integer, default: 0
  end
end
