class AddTitleAndTextToComments < ActiveRecord::Migration
  def change
    add_column :comments, :title, :string
    add_column :comments, :comment, :text
  end
end
