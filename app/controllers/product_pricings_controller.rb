class ProductPricingsController < ApplicationController
  filter_resource_access
  def index
    @product_pricings = ProductPricing.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @product_pricing = ProductPricing.find(params[:id])
  end

  def new
    @product_pricing = ProductPricing.new
  end

  def edit
    @product_pricing = ProductPricing.find(params[:id])
  end

  def create
    @product_pricing = ProductPricing.new(account_params)
    if @product_pricing.save
      flash[:info] = "Product Pricing created."
      redirect_to product_pricings_url
    else
      render 'new'
    end
  end

  def update
    @product_pricing = ProductPricing.find(params[:id])
    if @product_pricing.update_attributes(account_params)
      flash[:success] = "Product Pricing successfully updated!"
      redirect_to product_pricings_url
    else
      render :edit
    end
  end

  def destroy
    @product_pricing = ProductPricing.find(params[:id])
    product = Product.find(@product_pricing.product_id)
    if @product_pricing
      @product_pricing.destroy
    end
    redirect_to product
  end

  private

  def account_params
    params.require(:product_pricing).permit(:product_id, :from_date, :to_date, :amount)
  end
end