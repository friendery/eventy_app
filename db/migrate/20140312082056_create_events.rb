class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.integer :user_id

      t.timestamps
    end
    add_index :events, [:user_id, :created_at]
  end
end
