class CreateAccountingPeriod < ActiveRecord::Migration
  def change
    create_table :accounting_periods do |t|
      t.string :name, :null => false, unique: true
      t.datetime :date_from
      t.datetime :date_to
      t.string :status
    end
    add_index :accounting_periods, :name, unique: true
  end
end
