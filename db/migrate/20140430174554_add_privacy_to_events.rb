class AddPrivacyToEvents < ActiveRecord::Migration
  def change
    add_column :events, :privacy, :string, default: 'medium'
  end
end
