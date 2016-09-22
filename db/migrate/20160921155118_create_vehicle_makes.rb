class CreateVehicleMakes < ActiveRecord::Migration
  def change
    create_table :vehicle_makes do |t|
      t.string :name, :null => false, unique: true
    end
    add_index :vehicle_makes, :name, unique: true
  end
end
