class DropVehicleModelIdInProducts < ActiveRecord::Migration
  def change
    remove_foreign_key :products, name: "prodvclmdidx"
    remove_column :products, :vehicle_model_id
  end
end
