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

    already_uploaded = @images.size

    if(already_uploaded<4)
      bal = 4 - already_uploaded
      for i in 0..(bal-1)
        @product.images << Image.new
      end
    end
  end

  def new
    @product = Product.new
    @product.images.build

    for i in 0..(4-1)
      @product.images << Image.new
    end
    #@images = @product.images.build
  end

  def create

    @product = Product.new(product_params)
    if @product.save
      params[:images]['avatar'].each do |a|
        @image = @product.images.create!(:avatar => a, :product_id => @product.id)
      end
      @product = add_product_to_inventory
      redirect_to products_url
    else
      render :new
    end

  end

  def edit
    @product = Product.find(params[:id])
    @product = populate_product_inventory
    @images = @product.images

    already_uploaded = @images.size
    if(already_uploaded<4)
      bal = 4 - already_uploaded
      for i in 0..(bal-1)
        @product.images << Image.new
      end
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      params[:images]['avatar'].each do |a|
        @image = @product.images.create!(:avatar => a, :product_id => @product.id)
      end
      @product = add_product_to_inventory
      flash[:success] = "Product SKU  #{@product.sku}  successfully updated!"
      redirect_to products_url
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
    logger.info " \n\n\n\n\n\t\t product.inventory_id  : "+ inventoryproduct.id.to_s + "\n\n"
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
