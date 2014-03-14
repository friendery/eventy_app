class CreateEventjoinings < ActiveRecord::Migration
  def change
    drop_table :eventjoinings
    create_table :eventjoinings do |t|
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
    add_index :eventjoinings, :user_id
    add_index :eventjoinings, :event_id
    add_index :eventjoinings, [:user_id, :event_id], unique: true
  end
end
