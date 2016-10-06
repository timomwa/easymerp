class VehicleModelsController < ApplicationController
  filter_resource_access
  def index
    @vehicle_models = VehicleModel.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @vehicle_model = VehicleModel.find(params[:id])
    @vehicle_model =  populate_vehicle_make @vehicle_model
  end

  def new
    @vehicle_model = VehicleModel.new
  end

  def edit
    @vehicle_model = VehicleModel.find(params[:id])
    @vehicle_model =  populate_vehicle_make @vehicle_model
  end

  def create
    @vehicle_model = VehicleModel.new(vehicle_make_params)
    @vehicle_make = add_model_to_make @vehicle_model
    if @vehicle_model.save
      flash[:info] = "Vehicle Model  - \"#{@vehicle_model.name}\" - has been created."
      redirect_to vehicle_models_url
    else
      render 'new'
    end
  end

  def update
    @vehicle_model = VehicleModel.find(params[:id])
    if @vehicle_model.update_attributes(vehicle_make_params)
      flash[:success] = "Vehicle Model  \"#{@vehicle_model.name}\"  successfully updated!"
      redirect_to vehicle_models_url
    else
      render :edit
    end
  end

  def destroy
    @vehicle_model = VehicleModel.find(params[:id])
    if @vehicle_model
      @vehicle_model.destroy
    end
    redirect_to vehicle_models_url
  end

  private

  def add_model_to_make(vehicle_model)

    vehile_make = VehicleMake.find(vehicle_model.vehicle_make_id)
    if(!vehile_make.nil? && vehile_make.vehicle_models.nil?)
      vehile_make.vehicle_models = []
    end
    vehile_make.vehicle_models << vehicle_model
    vehile_make.save

    vehicle_model

  end

  private

  def vehicle_make_params
    params.require(:vehicle_model).permit(:name, :year, :vehicle_make_id)
  end

  private

  def populate_vehicle_make(vehicle_model)
    vehicle_model.vehicle_make_id  = vehicle_model.vehicle_make_id
    vehicle_model
  end
end