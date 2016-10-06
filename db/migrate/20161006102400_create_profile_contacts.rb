class CreateProfileContacts < ActiveRecord::Migration
  def change
    create_table :profile_contacts do |t|
      t.references :member_profile, references: :member_profiles, :null => false
      t.string :phone_no
      t.string :email_address
      t.string :postal_address
      t.string :physical_address
    end
    add_foreign_key :profile_contacts, :member_profiles, column: :member_profile_id, :name => "profcontpr_fk"

  end
end
