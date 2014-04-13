class AddMsgtypeToMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :type
    add_column :messages, :msgtype, :string
  end
end
