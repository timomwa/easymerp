class VehicleMake < ActiveRecord::Base
  has_many :vehicle_models
  attr_reader :vehicle_models
  attr_writer :vehicle_models
  
  def self.with_ids(ids)
    where(id: ids)
  end

  def self.search(query, page = 1)
    if(!query.nil? && !query.empty?)
      wildcard_search = "%#{query}%"
      psttmt = where("name LIKE ? ", wildcard_search)
      psttmt = psttmt.page(page)
      psttmt = psttmt.per_page(5)
    end
  end

  def self.find_by_model_name(query, page = 1)
    if(!query.nil? && !query.empty?)
      wildcard_search = "%#{query}%"
      psttmt = select("vehicle_models.id, CONCAT_WS(' ',vehicle_models.year,vehicle_models.name,vehicle_makes.name) as name")
      psttmt = psttmt.joins(:vehicle_models).where('vehicle_models.name LIKE ?', wildcard_search)
      psttmt = psttmt.page(page)
      psttmt = psttmt.per_page(5)
    end
  end

  def self.find_by_model_id(query, page = 1)
    if(!query.nil?)
      psttmt = select("vehicle_models.id, CONCAT_WS(' ',vehicle_models.year,vehicle_models.name,vehicle_makes.name) as name")
      psttmt = psttmt.joins(:vehicle_models).where('vehicle_models.id  = ?', query)
      psttmt = psttmt.page(page)
      psttmt = psttmt.per_page(5)
    end
  end
end