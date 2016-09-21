class AlterGeneralLedgerAddTranscodeAndDesc < ActiveRecord::Migration
  def change
    add_column :general_ledgers, :transaction_ref, :string, :default => 'TXN000', :null => false
    add_column :general_ledgers, :seq, :string, :default => 'SEQ0001', :null => false
    add_column :general_ledgers, :description, :text

    add_index :general_ledgers, :transaction_ref, unique: true
    add_index :general_ledgers, :seq, unique: true
  end
end
