class CreateGlMapping < ActiveRecord::Migration
  def change
    create_table :gl_mappings do |t|
      t.references :transaction_type, references: :transaction_types,:null => false
      t.references :debit_account, references: :accounts,:null => false
      t.references :credit_account, references: :accounts,:null => false
      t.timestamps null: false
    end
    add_foreign_key :gl_mappings, :transaction_types, column: :transaction_type_id
    add_foreign_key :gl_mappings, :accounts, column: :debit_account_id
    add_foreign_key :gl_mappings, :accounts, column: :credit_account_id
  end
end
