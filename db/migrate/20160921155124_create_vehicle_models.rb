class CreateVehicleModels < ActiveRecord::Migration
  def change
    create_table :vehicle_models do |t|
      t.string :name, :null => false, unique: true
      t.integer :year, :null => false
      t.references :vehicle_make, references: :vehicle_makes, :null => false
    end
    add_foreign_key :vehicle_models, :vehicle_makes, column: :vehicle_make_id
    add_index :vehicle_models, :name
    add_index :vehicle_models, :year
    add_index :vehicle_models, :vehicle_make_id
    add_index :vehicle_models, [:name,:year,:vehicle_make_id], unique: true, :name => 'vclemakeid'
  end
end
