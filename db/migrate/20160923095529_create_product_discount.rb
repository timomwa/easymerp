class CreateProductDiscount < ActiveRecord::Migration
  def change
    create_table :product_discounts do |t|
      t.references :product, references: :products, :null => false
      t.integer :type, :limit => 2, :null => false, :null => false, :default =>0
      t.decimal :percent, :precision => 35, :scale => 5
      t.datetime :date_from
      t.datetime :date_to
      t.boolean :active, :default => false
    end
    add_foreign_key :product_discounts, :products, column: :product_id
    add_index :product_discounts, :product_id, :name => 'pdprodctidx'
    add_index :product_discounts, :date_from, :name => 'pddtfrmidx'
    add_index :product_discounts, :date_to, :name => 'pddttoidx'
    add_index :product_discounts, :type, :name => 'pdtpidx'
    add_index :product_discounts, [:product_id,:date_from, :date_to, :type], unique: true, :name => 'discntsidx'

  end
end
