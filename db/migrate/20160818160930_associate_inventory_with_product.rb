class AssociateInventoryWithProduct < ActiveRecord::Migration
  def change
    create_table :inventory_products do |t|
      t.references :inventory, references:  :inventories
      t.references :product,  references: :products
    end
  end
end
