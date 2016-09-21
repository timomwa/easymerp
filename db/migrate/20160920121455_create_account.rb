class CreateAccount < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name, :null => false, unique: true
      t.string :code, :null => false, unique: true
      t.timestamps null: false
      t.string :description
    end
    add_index :accounts, :name, unique: true
    add_index :accounts, :code, unique: true
  end
end
