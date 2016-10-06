class CreateProfileStickers < ActiveRecord::Migration
  def change
    create_table :profile_stickers do |t|
      t.references :member_profile, references: :member_profiles, :null => false
      t.string :number
    end
    add_foreign_key :profile_stickers, :member_profiles, column: :member_profile_id, :name => "profstk_fk"
    add_index :profile_stickers, :number
  end
end
