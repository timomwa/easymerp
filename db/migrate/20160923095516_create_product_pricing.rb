class CreateProductPricing < ActiveRecord::Migration
  def change
    create_table :product_pricings do |t|
      t.references :product, references: :products, :null => false
      t.datetime :date_from
      t.datetime :date_to
      t.decimal :amount, :precision => 35, :scale => 5
    end
    add_foreign_key :product_pricings, :products, column: :product_id
    add_index :product_pricings, :product_id, :name => 'prodidx'
    add_index :product_pricings, :date_from, :name => 'dtfrmidx'
    add_index :product_pricings, :date_to, :name => 'dttoidx'
    add_index :product_pricings, [:date_from,:date_to], unique: true, :name => 'dtrangeidx'

  end
end
