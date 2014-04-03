class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :mark, default: 0

      t.timestamps
    end
      add_index :rates, :user_id
      add_index :rates, :event_id
      add_index :rates, [:user_id, :event_id], unique: true
      add_index :rates, :mark
  end
end
