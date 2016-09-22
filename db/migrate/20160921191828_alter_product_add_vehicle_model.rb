class AlterProductAddVehicleModel < ActiveRecord::Migration
  def change
    add_reference :products, :vehicle_model, index: true
  end
end
