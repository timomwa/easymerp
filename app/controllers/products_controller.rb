class ProductsController < ApplicationController
  #filter_resource_access
  #include ActionController::MimeResponds
  #include ActionController::ImplicitRender
  #before_action :all_products, only: [:index, :create]
  #respond_to :html,:js
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @product = Product.find(params[:id])
    @product = populate_product_inventory
    @images = @product.images
    @product.vehicle_models  = ProductsVehicleModels.find_by(product: @product)
  end

  def new
    @product = Product.new
    @product.images.build
    @product.vehicle_models = []
  end

  def create

    @product = Product.new(product_params)
    if @product.save
      if(!params[:images].nil? && !params[:images]['avatar'].nil?)
        params[:images]['avatar'].each do |a|
          @image = @product.images.create!(:avatar => a, :product_id => @product.id)
        end
      end

      if(!params[:product].nil? && !params[:product]['vehicle_models'].nil?)
        cleanvms = params[:product]['vehicle_models']  - ["NULL"]
        cleanvms = cleanvms.reject { |c| c.empty? }
        ProductsVehicleModels.where(product: @product).where.not(vehicle_model_id: cleanvms).delete_all;
        cleanvms.each do |vm|
          if(!vm.nil? & !vm.empty?)
            vehicle_model = VehicleModel.find(vm)
            mapping  = ProductsVehicleModels.find_by(product: @product, vehicle_model: vehicle_model)
            if(mapping.nil?)
              @product_vehicle_model = ProductsVehicleModels.new
              @product_vehicle_model.product = @product
              @product_vehicle_model.vehicle_model  = vehicle_model
              @product_vehicle_model.save!
            end
          end
        end
      end

      if(!params[:vehicle_models].nil?)
        params[:images]['vehicle_models'].each do |vm|
          @vehicle_model = @product.vehicle_models.create!(:product => @product, :vehicle_model => vm)
        end
      end

      @product = add_product_to_inventory
      flash[:info] = "Product saved successfully."
      redirect_to @product
    else
      render :new
    end

  end

  def edit
    @product = Product.find(params[:id])
    @product = populate_product_inventory
    @images = @product.images
    @product.vehicle_models = ProductsVehicleModels.find_by_productid @product.id
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      if(!params[:images].nil? && !params[:images]['avatar'].nil?)
        params[:images]['avatar'].each do |a|
          @image = @product.images.create!(:avatar => a, :product_id => @product.id)
        end
      end

      if(!params[:product].nil? && !params[:product]['vehicle_models'].compact.nil?)
        cleanvms = params[:product]['vehicle_models']  - ["NULL"]
        cleanvms = cleanvms.reject { |c| c.empty? }
        ProductsVehicleModels.where(product: @product).where.not(vehicle_model_id: cleanvms).delete_all;
        cleanvms.each do |vm|
          if(!vm.nil? & !vm.empty?)
            vehicle_model = VehicleModel.find(vm)
            mapping  = ProductsVehicleModels.find_by(product: @product, vehicle_model: vehicle_model)
            if(mapping.nil?)
              @product_vehicle_model = ProductsVehicleModels.new
              @product_vehicle_model.product = @product
              @product_vehicle_model.vehicle_model  = vehicle_model
              @product_vehicle_model.save!
            end
          end
        end
      end

      @product = add_product_to_inventory
      flash[:success] = "Product SKU  #{@product.sku}  successfully updated!"
      redirect_to @product
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:vehicle_model_id, :name, :sku, :count, :description, :inventory_id)
  end

  private

  def add_product_to_inventory
    inventory_id = params[:product][:inventory_id]

    inventory = Inventory.find(inventory_id)
    inventoryproduct = InventoryProduct.find_by(product: @product)#, inventory: inventory)

    if(inventoryproduct.nil?)
      inventoryproduct = InventoryProduct.new
      inventoryproduct.product = @product
    end

    inventoryproduct.inventory = inventory
    inventoryproduct.save

    inventoryproduct.product
  end

  private

  def populate_product_inventory

    inventoryproduct = InventoryProduct.find_by(product: @product)
    if(!inventoryproduct.nil?)
      @inventory = inventoryproduct.inventory
      @product.inventory_id = @inventory.id
    end
    @product
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  private

  def all_products
    @products = Product.paginate(:page => params[:page], :per_page => 5)
    #respond_to do |format|
    #  format.html
    #  format.js
    #  format.js
    #end
  end

end
