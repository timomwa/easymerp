class Product < ActiveRecord::Base
  belongs_to :inventory
  validates :sku, presence: true, uniqueness: true
end
 