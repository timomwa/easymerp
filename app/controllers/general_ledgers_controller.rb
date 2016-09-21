class GeneralLedgersController < ApplicationController
  def index
    @general_ledgers = GeneralLedger.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @general_ledger = GeneralLedger.find(params[:id])
  end

  def new
    @general_ledger = GeneralLedger.new
  end

  def edit
    @general_ledger = GeneralLedger.find(params[:id])
  end

  def create
    @general_ledger = GeneralLedger.new(gl_params)
    if @general_ledger.save
      flash[:info] = "The GL  - \"#{@general_ledger.name}\" - has been created."
      redirect_to accountingpanel_url
    else
      render 'new'
    end
  end

  def update
    @general_ledger = GeneralLedger.find(params[:id])
    if @general_ledger.update_attributes(gl_params)
      flash[:success] = "The GL  \"#{@general_ledger.name}\"  successfully updated!"
      redirect_to accountingpanel_url
    else
      render :edit
    end
  end

  def destroy
    @general_ledger = GeneralLedger.find(params[:id])
    if @general_ledger
      @general_ledger.destroy
    end
    redirect_to accountingpanel_url
  end

  private

  def gl_params
    params.require(:general_ledger).permit(:account_id, :accounting_period_id, :amount, :entry_date, :cr_dr_flag, :transaction_ref, :description)
  end
end