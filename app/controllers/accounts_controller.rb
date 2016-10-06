class AccountsController < ApplicationController
  filter_resource_access
  def index
    @accounts = Account.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @account = Account.find(params[:id])
  end

  def new
    @account = Account.new
  end

  def edit
    @account = Account.find(params[:id])
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      flash[:info] = "The Account  - \"#{@account.name}\" - has been created."
      redirect_to accountingpanel_url
    else
      render 'new'
    end
  end

  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(account_params)
      flash[:success] = "The Account  \"#{@account.name}\"  successfully updated!"
      redirect_to accountingpanel_url
    else
      render :edit
    end
  end

  def destroy
    @account = Account.find(params[:id])
    if @account
      @account.destroy
    end
    redirect_to accountingpanel_url
  end

  private

  def account_params
    params.require(:account).permit(:name, :code, :description)
  end
end