class AddIndexSkuCountDesc < ActiveRecord::Migration
  def change
    add_column :products, :sku, :string, :default => 'SKU01', :null => false
    add_column :products, :count, :integer, :default => 0, :null => false
    add_column :products, :description, :text
    
    add_index :products, :name
    add_index :products, :sku, unique: true
  end
end
