class AlterColumnName < ActiveRecord::Migration
  def change
    rename_column :accounting_periods, :date_from, :fromDate
    rename_column :accounting_periods, :date_to, :toDate
  end
end
