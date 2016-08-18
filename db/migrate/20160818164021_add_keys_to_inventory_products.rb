class AddKeysToInventoryProducts < ActiveRecord::Migration
  def change
    add_foreign_key :inventory_products, :inventories, column: :inventory_id
    add_foreign_key :inventory_products, :products, column: :product_id
  end
end
