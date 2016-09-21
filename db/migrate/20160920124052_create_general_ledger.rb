class CreateGeneralLedger < ActiveRecord::Migration
  def change
    create_table :general_ledgers do |t|
      t.references :account, references: :accounts
      t.references :accounting_period, references: :accounting_periods
      t.decimal :amount, :precision => 35, :scale => 5
      t.datetime :entry_date, null: false
      t.integer :cr_dr_flag, default: 1
    end
    add_foreign_key :general_ledgers, :accounts, column: :account_id
    add_foreign_key :general_ledgers, :accounting_periods, column: :accounting_period_id

  end
end
