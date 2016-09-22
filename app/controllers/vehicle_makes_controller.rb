class VehicleMakesController < ApplicationController
  def index
    @vehicle_makes = VehicleMake.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @vehicle_make = VehicleMake.find(params[:id])
  end

  def new
    @vehicle_make = VehicleMake.new
  end

  def edit
    @vehicle_make = VehicleMake.find(params[:id])
  end

  def create
    @vehicle_make = VehicleMake.new(vehicle_make)
    if @vehicle_make.save
      flash[:info] = "Vehicle Make  - \"#{@vehicle_make.name}\" - has been created."
      redirect_to vehicle_makes_url
    else
      render 'new'
    end
  end

  def update
    @vehicle_make = VehicleMake.find(params[:id])
    if @vehicle_make.update_attributes(vehicle_make)
      flash[:success] = "Vehicle Make  \"#{@vehicle_make.name}\"  successfully updated!"
      redirect_to vehicle_makes_url
    else
      render :edit
    end
  end

  def destroy
    @vehicle_make = VehicleMake.find(params[:id])
    if @vehicle_make
      @vehicle_make.destroy
    end
    redirect_to vehicle_makes_url
  end

  private

  def vehicle_make
    params.require(:vehicle_make).permit(:name)
  end
  
  
end