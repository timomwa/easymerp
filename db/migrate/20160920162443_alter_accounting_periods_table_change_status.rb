class AlterAccountingPeriodsTableChangeStatus < ActiveRecord::Migration
  def change
    change_column :accounting_periods, :status, :tinyint, :limit =>1
  end
end
