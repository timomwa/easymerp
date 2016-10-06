class CreateProfileCars < ActiveRecord::Migration
  def change
    create_table :profile_cars do |t|
      t.references :member_profile, references: :member_profiles, :null => false
      t.references :vehicle_model, references: :vehicle_models, :null => false
      t.string :color
      t.string :regNo
      t.string :petname
    end

    add_foreign_key :profile_cars, :member_profiles, column: :member_profile_id, :name => "profcarpr_fk"
    add_foreign_key :profile_cars, :vehicle_models, column: :vehicle_model_id, :name => "vmprofcarpr_fk"

  end
end
