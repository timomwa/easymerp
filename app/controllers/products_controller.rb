class ProductsController < ApplicationController
  filter_resource_access
  def index
    @products = Product.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @product = Product.find(params[:id])
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
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:success] = "Product SKU  #{@product.sku}  successfully updated!"
      redirect_to products_url
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :sku, :count, :description)
  end
end
