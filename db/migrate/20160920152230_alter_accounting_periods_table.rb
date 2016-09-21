class AlterAccountingPeriodsTable < ActiveRecord::Migration
  def change
    change_column :accounting_periods, :toDate, :datetime, :null => false
    change_column :accounting_periods, :fromDate, :datetime, :null => false
    
    add_index :accounting_periods, :toDate, unique: true
    add_index :accounting_periods, :fromDate, unique: true
  end
end
