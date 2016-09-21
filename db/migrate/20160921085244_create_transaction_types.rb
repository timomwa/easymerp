class CreateTransactionTypes < ActiveRecord::Migration
  def change
    create_table :transaction_types do |t|
      t.string :name, :null => false, unique: true
      t.string :trx_code, :null => false, unique: true
      t.timestamps null: false
      t.string :description
    end
    add_index :transaction_types, :name, unique: true
    add_index :transaction_types, :trx_code, unique: true
  end
end
