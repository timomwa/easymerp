class AddActiveField < ActiveRecord::Migration
  def change
    add_column :users, :active, :boolean, :default => false, :null => false
    add_column :users, :approved, :boolean, :default => false
    add_column :users, :confirmed, :boolean, :default => false
    add_column :users, :single_access_token, :string
  end
end
