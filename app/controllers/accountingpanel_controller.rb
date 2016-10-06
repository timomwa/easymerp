class AccountingpanelController < ApplicationController
  #filter_resource_access
  def index
    @accounts = Account.paginate(:page => params[:page], :per_page => 10)
    @accounting_periods = AccountingPeriod.paginate(:page => params[:page], :per_page => 10)
    @general_ledgers = GeneralLedger.paginate(:page => params[:page], :per_page => 10)
    @transaction_types = TransactionType.paginate(:page => params[:page], :per_page => 10)
    @gl_mappings = GlMapping.paginate(:page => params[:page], :per_page => 10)
   
  end
end