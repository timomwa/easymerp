class ProductPricing < ActiveRecord::Base
  belongs_to :product

  def self.findActivePricing(product_id)
    where("product_id = ?  and (? between date_from and date_to) ", product_id, Date.today ).order("date_from ASC, date_to ASC").first
  end
end