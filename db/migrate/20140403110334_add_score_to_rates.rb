class AddScoreToRates < ActiveRecord::Migration
  def change
    remove_column :rates, :mark
    add_column :rates, :score, :integer, default: 0
  end
end
