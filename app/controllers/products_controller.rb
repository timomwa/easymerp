class ProductsController < ApplicationController
  #filter_resource_access
  #include ActionController::MimeResponds
  #include ActionController::ImplicitRender
  #before_action :all_products, only: [:index, :create]
  #respond_to :html,:js
  def index
    @products = Product.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @product = Product.find(params[:id])
    @product = populate_product_inventory
  end

  def new
    @product = Product.new
  end

  def create

    @product = Product.new(product_params)
    if @product.save
      redirect_to products_url
    else
      render :new
    end

  end

  def edit
    @product = Product.find(params[:id])
    @product = populate_product_inventory
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
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
    @product
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

  def customer_view
    respond_to do |format|
      format.html
      format.js
    end
  end

end
