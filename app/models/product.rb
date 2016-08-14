class Product < ActiveRecord::Base
  validates :sku, presence: true, uniqueness: true
end
