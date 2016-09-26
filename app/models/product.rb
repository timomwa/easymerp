class Product < ActiveRecord::Base
  belongs_to :inventory
  belongs_to :vehicle_models
  has_many :images
  accepts_nested_attributes_for :images
  validates :sku, presence: true, uniqueness: true
  attr_reader :inventory_id
  attr_writer :inventory_id
  
  attr_reader :vehicle_models
  attr_writer :vehicle_models
end
