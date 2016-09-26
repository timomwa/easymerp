class RenameProductVehicleModel < ActiveRecord::Migration
  def change
    rename_table :product_vehicle_models, :products_vehicle_models
  end
end
