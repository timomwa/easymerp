class SearchController < ApplicationController
  def index
  end

  def search
    term = params[:term]
    type = params[:_type]
    q = params[:q]
    object = params[:object]

    if(!object.nil? && object == "vehicle_model")
      @vehicle_makes = VehicleMake.find_by_model_name q;
      total_count = 0
      if(@vehicle_makes.nil?)
        @vehicle_makes = []
      end
      respond_to do |format|
        format.js   { render :json => @vehicle_makes, :total_count => total_count }
      end
    end

  end

end