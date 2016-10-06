class SearchController < ApplicationController

  #filter_access_to
  
  def index
  end

  def search
    #logger.info "\n\n\t params ----> \n\n"+params.to_s+"\n\n"
    term = params[:term]
    type = params[:_type]
    q = params[:q]
    object = params[:object]

    if(!object.nil? && object == "vehicle_model")
      product_id = params[:product_id]
      @vehicle_makes =!q.nil? ? (VehicleMake.find_by_model_name q) : nil;
      #total_count = 0
      if(@vehicle_makes.nil?)
        @vehicle_makes = !product_id.nil? ? (ProductsVehicleModels.find_by_productid product_id) : []
      end
      respond_to do |format|
        format.js   { render :json => @vehicle_makes }
      end
    end

  end

end