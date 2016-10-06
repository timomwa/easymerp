class CreateMemberProfile < ActiveRecord::Migration
  def change
    create_table :member_profiles do |t|
      t.references :user, references: :users, :null => false
      t.integer :status, :limit => 2, :null => false, :null => false, :default =>0
    end
    add_foreign_key :member_profiles, :users, column: :user_id, :name => "memprofus_fk"
  end
end
