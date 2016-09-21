class CreateSequence < ActiveRecord::Migration
  def change
    create_table :sequences do |t|
      t.string :name, :null => false, unique: true
      t.string :prefix, :null => false
      t.string :suffix, :null => false
      t.integer :next_val, :limit => 8, :null => false
      t.timestamps null: false
    end
    add_index :sequences, [:prefix,:suffix], unique: true

  end
end

