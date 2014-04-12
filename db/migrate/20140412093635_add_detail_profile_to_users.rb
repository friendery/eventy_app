class AddDetailProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hobby,       :string
    add_column :users, :DOB,         :string
    add_column :users, :gender,      :string
    add_column :users, :nationality, :string
    add_column :users, :mobile,      :string
    add_column :users, :occupation,  :string
    add_column :users, :address,     :string
    add_column :users, :webpage,     :string
    add_column :users, :self_intro,  :string
  end
end
