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
    @product.product_pricings.build
    @product.product_discounts.build
    @product.vehicle_models = []
  end

  def create

    @product = Product.new(product_params)
    if @product.save
      extract_extra_attribs
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

      extract_extra_attribs

      flash[:success] = "Product SKU  #{@product.sku}  successfully updated!"
      redirect_to @product
    else
      render :edit
    end
  end

  def delete_pricing
    pricing = ProductPricing.find(params[:id]);
    product = pricing.product
    pricing.delete
    redirect_to product
  end
  
  def toggle_discount_active
    discount = ProductDiscount.find(params[:id]);
    discount.active  = !discount.active
    product = discount.product
    discount.save
    redirect_to product
  end
  
  def delete_discount
    discount = ProductDiscount.find(params[:id]);
    product = discount.product
    discount.delete
    redirect_to product
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

    @product = inventoryproduct.product
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
  end

  private

  def extract_extra_attribs

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

    if(!params[:product].nil? && !params[:product]['product_pricings'].nil?)
      date_from = params[:product]['product_pricings']['date_from']
      date_to = params[:product]['product_pricings']['date_to']
      if(!date_from.nil? && !date_from.nil? && !date_from.empty? && !date_from.empty?)
        product_pricing = ProductPricing.new
        product_pricing.amount = params[:product]['product_pricings']['amount']
        product_pricing.date_from = params[:product]['product_pricings']['date_from']
        product_pricing.date_to = params[:product]['product_pricings']['date_to']
        product_pricing.product = @product
        product_pricing.save!
      end
    end

    if(!params[:product].nil? && !params[:product]['product_discounts'].nil?)
      date_from = params[:product]['product_discounts']['date_from']
      date_to = params[:product]['product_discounts']['date_to']
      if(!date_from.nil? && !date_from.nil? && !date_from.empty? && !date_from.empty?)
        product_discount = ProductDiscount.new
        product_discount.percent = params[:product]['product_discounts']['percent']
        product_discount.date_from = params[:product]['product_discounts']['date_from']
        product_discount.date_to = params[:product]['product_discounts']['date_to']
        product_discount.active = params[:product]['product_discounts']['active']
        product_discount.discount_type = params[:product]['product_discounts']['discount_type']
        product_discount.product = @product
        product_discount.save!
      end
    end

    if(!params[:vehicle_models].nil?)
      params[:images]['vehicle_models'].each do |vm|
        @vehicle_model = @product.vehicle_models.create!(:product => @product, :vehicle_model => vm)
      end
    end

    @product = add_product_to_inventory
  end
end
