class RenameTypeInProductDiscountsToDiscountType < ActiveRecord::Migration
  def change
    rename_column :product_discounts, :type, :discount_type
  end
end
