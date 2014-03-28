class AddStatusToEventjoinings < ActiveRecord::Migration
  def change
    add_column :eventjoinings, :status, :string, default: 'pending'
  end
end
