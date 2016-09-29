class ProductDiscount < ActiveRecord::Base
  belongs_to :product
  validates :discount_type, presence: true
  enum discount_type: { MEMBERS_ONLY: 0, GENERAL_PUBLIC: 1, SPECIAL: 2 }

  def self.findActiveDiscounts(product_id, discount_type)
    where("product_id = ?  and discount_type = ? and (? between date_from and date_to) and active = 1", product_id, discount_type, Date.today ).order("date_from ASC, date_to ASC").first
  end
end