class Inventory < ActiveRecord::Base
  has_many :products
  has_many :images
  accepts_nested_attributes_for :images
end
