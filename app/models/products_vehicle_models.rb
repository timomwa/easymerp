class ProductsVehicleModels < ActiveRecord::Base
  belongs_to :product
  belongs_to :vehicle_model
  
  def self.find_by_productid(query, page = 1)
    if(!query.nil?)
      psttmt = select("vehicle_models.id, CONCAT_WS(' ',vehicle_models.year,vehicle_models.name) as name, vehicle_models.vehicle_make_id as vehicle_make_id")
      psttmt = psttmt.joins(:product).where("products.id = ? ", query)
      psttmt = psttmt.joins(:vehicle_model)
      psttmt = psttmt.where('products_vehicle_models.product_id  = ?', query)
    end
  end

  def to_s
    "Product: #{product.name} Vehicle Model: { Name:  #{vehicle_model.name}, Year:  #{vehicle_model.year} }"
  end
end