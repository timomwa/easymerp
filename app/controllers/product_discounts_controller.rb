class ProductDiscountsController < ApplicationController
  def index
    @product_discounts = ProductDiscount.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @product_discount = ProductDiscount.find(params[:id])
  end

  def new
    @product_discount = ProductDiscount.new
  end

  def edit
    @product_discount = ProductDiscount.find(params[:id])
  end

  def create
    @product_discount = ProductDiscount.new(account_params)
    if @product_discount.save
      flash[:info] = "Product Discount created."
      redirect_to product_discounts_url
    else
      render 'new'
    end
  end

  def update
    @product_discount = ProductDiscount.find(params[:id])
    if @product_discount.update_attributes(account_params)
      flash[:success] = "Product Discount successfully updated!"
      redirect_to product_discounts_url
    else
      render :edit
    end
  end

  def destroy
    @product_discount = ProductDiscount.find(params[:id])
    if @product_discount
      @product_discount.destroy
    end
    redirect_to product_discounts_url
  end

  private

  def account_params
    params.require(:product_discount).permit(:product_id, :type, :percentage, :from_date, :to_date, :amount, :active)
  end
end