class CreateAccountBalance < ActiveRecord::Migration
  def change
    create_table :account_balances do |t|
      t.references :account, references: :accounts
      t.references :accounting_period, references: :accounting_periods

      t.decimal :amount, :precision => 35, :scale => 5
    end
    add_foreign_key :account_balances, :accounts, column: :account_id
    add_foreign_key :account_balances, :accounting_periods, column: :accounting_period_id
  end
end
