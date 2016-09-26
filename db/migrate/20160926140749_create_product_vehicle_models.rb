class CreateProductVehicleModels < ActiveRecord::Migration
  def change
    create_table :product_vehicle_models do |t|
      t.references :product, references: :products, :null => false
      t.references :vehicle_model, references: :vehicle_models, :null => false
    end
    add_foreign_key :product_vehicle_models, :products, column: :product_id, :name => "pvmprodidfk"
    add_foreign_key :product_vehicle_models, :vehicle_models, column: :vehicle_model_id, :name => "pvmvmidfk"
    add_index :product_vehicle_models, :product_id, :name => 'pvmprdidx'
    add_index :product_vehicle_models, :vehicle_model_id, :name => 'pvmvmidx'
  end
end
