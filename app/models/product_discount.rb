class ProductDiscount < ActiveRecord::Base
  belongs_to :product
  validates :discount_type, presence: true
  enum discount_type: { MEMBERS_ONLY: 0, GENERAL_PUBLIC: 1, SPECIAL: 2 }
  #attr_reader :discount_types
  #attr_writer :discount_types

end