class CreateImage < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :product, references: :products, :null => false
      t.string :avatar
      t.integer :type, :limit => 2, :null => false, :null => false, :default =>0
      t.boolean :active, :true => false
      t.boolean :defaultimg, :default => false
      t.timestamps
    end
    add_foreign_key :images, :products, column: :product_id
    add_index :images, :product_id, :name => 'imgprdidx'
    add_index :images, :type, :name => 'imgtpeidx'
    add_index :images, :active, :name => 'imgactvidx'
    add_index :images, :defaultimg, :name => 'imgdeftimgidx'
    add_index :images, [:product_id,:type, :active, :defaultimg], unique: true, :name => 'imguniqcstridx'
  end
end
