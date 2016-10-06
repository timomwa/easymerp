class InventoriesController < ApplicationController
  filter_resource_access
  def index
    @inventories = Inventory.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @inventory = Inventory.find(params[:id])
  end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)
    if @inventory.save
      flash[:info] = "Inventory created"
      redirect_to inventories_url
    else
      render 'new'
    end
  end

  def edit
    @inventory = Inventory.find(params[:id])
  end

  def update
    @inventory = Inventory.find(params[:id])
    if @inventory.update_attributes(inventory_params)
      flash[:success] = "Inventoriy update success!"
      redirect_to inventories_url
    else
      render :edit
    end
  end

  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy
    redirect_to inventories_url
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name)
  end
end