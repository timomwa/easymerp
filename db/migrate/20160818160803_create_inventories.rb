class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :name, :null => false, unique: true
      
      t.timestamps null: false
    end
  end
end
