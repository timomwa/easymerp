class TransactionTypesController < ApplicationController

  filter_resource_access
  
  def index
    @transaction_types = TransactionType.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @transaction_type = TransactionType.find(params[:id])
  end

  def new
    @transaction_type = TransactionType.new
  end

  def edit
    @transaction_type = TransactionType.find(params[:id])
  end

  def create
    @transaction_type = TransactionType.new(transaction_type_params)
    logger.info "\n\n\n\t\t GENERATED TX CODE -> "+(@transaction_type.trx_code.nil? ? "null" : @transaction_type.trx_code) + "\n\n"
    if @transaction_type.save
      flash[:info] = "The Transaction Type  - \"#{@transaction_type.name}\" - has been created."
      redirect_to accountingpanel_url
    else
      render 'new'
    end
  end

  def update
    @transaction_type = TransactionType.find(params[:id])
    if @transaction_type.update_attributes(transaction_type_params)
      flash[:success] = "The Transaction Type  \"#{@transaction_type.name}\"  successfully updated!"
      redirect_to accountingpanel_url
    else
      render :edit
    end
  end

  def destroy
    @transaction_type = TransactionType.find(params[:id])
    if @transaction_type
      @transaction_type.destroy
    end
    redirect_to accountingpanel_url
  end

  private

  def transaction_type_params
    params.require(:transaction_type).permit(:name, :trx_code, :description)
  end
end