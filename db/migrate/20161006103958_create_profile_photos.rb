class CreateProfilePhotos < ActiveRecord::Migration
  def change
    create_table :profile_photos do |t|
      t.references :member_profile, references: :member_profiles, :null => false
      t.string :avatar
      t.boolean :active, :true => false
      t.boolean :defaultimg, :default => false
      t.timestamps
    end
    add_foreign_key :profile_photos, :member_profiles, column: :member_profile_id, :name => "profimg_fk"
    
    add_index :profile_photos, :member_profile_id, :name => 'propicmemb_idx'
    add_index :profile_photos, :active, :name => 'propicactive_idx'
    add_index :profile_photos, :defaultimg, :name => 'propicdefaultimg_idx'
    add_index :profile_photos, [:member_profile_id,:active, :defaultimg], unique: true, :name => 'propicactv_idx'

  end
end
