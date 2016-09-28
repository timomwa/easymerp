class AlterProductsRemoveSkuDefaultVa < ActiveRecord::Migration
  def change
    add_column :products, :sku, :string, :default => nil, :null => false
  end
end
