class VehicleModel < ActiveRecord::Base
  belongs_to :vehicle_make
  has_many :products
  attr_reader :vehicle_make
  attr_writer :vehicle_make
    
  def self.search(query, page = 1)
    if(!query.nil? && !query.empty?)
      wildcard_search = "%#{query}%"
      psttmt = where("name LIKE ? ", wildcard_search)
      psttmt = psttmt.page(page)
      psttmt = psttmt.per_page(5)
    end
  end
end