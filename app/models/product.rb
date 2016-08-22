class Product < ActiveRecord::Base
  belongs_to :inventory
  validates :sku, presence: true, uniqueness: true
  attr_reader :inventory_id
  attr_writer :inventory_id
end
