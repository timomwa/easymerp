class CreateProfileCarPhotos < ActiveRecord::Migration
  def change
    create_table :profile_car_photos do |t|
      t.references :profile_car, references: :profile_cars, :null => false
      t.string :avatar
      t.boolean :active, :true => false
      t.boolean :defaultimg, :default => false
      t.timestamps
    end

    add_foreign_key :profile_car_photos, :profile_cars, column: :profile_car_id, :name => "profcarphot_fk"

    add_index :profile_car_photos, :profile_car_id, :name => 'mbrpro_idx'
    add_index :profile_car_photos, :active, :name => 'profcaract_idx'
    add_index :profile_car_photos, :defaultimg, :name => 'defaultimg_idx'
   
  end
end
