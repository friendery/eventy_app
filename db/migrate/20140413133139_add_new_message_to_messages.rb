class AddNewMessageToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :new_message, :boolean, default: true
  end
end
