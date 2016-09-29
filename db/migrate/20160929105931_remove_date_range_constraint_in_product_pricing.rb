class RemoveDateRangeConstraintInProductPricing < ActiveRecord::Migration
  def change
    add_index :product_pricings, [:date_from,:date_to, :product_id], unique: true, :name => 'dtrangeidx'
  end
end
