class AlterTableImage < ActiveRecord::Migration
  def change
    rename_column :images, :type, :owner_type
  end
end
