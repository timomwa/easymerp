class AccountingPeriodsController < ApplicationController
  def index
    @accounting_periods = AccountingPeriod.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @accounting_period = AccountingPeriod.find(params[:id])
  end

  def new
    @accounting_period = AccountingPeriod.new
  end

  def edit
    @accounting_period = AccountingPeriod.find(params[:id])
  end

  def create
    @accounting_period = AccountingPeriod.new(accounting_period_params)

    logger.info "\n\n\n\t\ttoDate::: "+ (params[:toDate].nil? ? "NULL" : params[:toDate])
    logger.info "\n\n\n\t\tfromDate::: "+ (params[:fromDate].nil? ? "NULL" : params[:fromDate])

    if @accounting_period.save
      flash[:info] = "The Accounting Period - \"#{@accounting_period.name}\" - has been created."
      redirect_to accountingpanel_url
    else
      render 'new'
    end
  end

  def update
    @accounting_period = AccountingPeriod.find(params[:id])
    if @accounting_period.update_attributes(accounting_period_params)
      flash[:success] = "The Accounting Period \"#{@accounting_period.name}\"  successfully updated!"
      redirect_to accountingpanel_url
    else
      render :edit
    end
  end

  def destroy
    @accounting_period = AccountingPeriod.find(params[:id])
    if @accounting_period
      @accounting_period.destroy
    end
    redirect_to accountingpanel_url
  end

  private

  def accounting_period_params
    params.require(:accounting_period).permit(:name, :fromDate, :toDate, :status)
  end
end