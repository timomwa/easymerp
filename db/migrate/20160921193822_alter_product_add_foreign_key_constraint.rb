class AlterProductAddForeignKeyConstraint < ActiveRecord::Migration
  def change
    add_foreign_key :products, :vehicle_models, column: :vehicle_model_id, :name => "prodvclmdidx"
  end
end
