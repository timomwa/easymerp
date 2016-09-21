class GlMappingsController < ApplicationController
  def index
    @gl_mappings = GLMapping.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @gl_mapping = GLMapping.find(params[:id])
  end

  def new
    @gl_mapping = GLMapping.new
  end

  def edit
    @gl_mapping = GLMapping.find(params[:id])
  end

  def create
    @gl_mapping = GLMapping.new(gl_mapping_params)
    
    if @gl_mapping.save
      flash[:info] = "Mapping has been created."
      redirect_to accountingpanel_url
    else
      render 'new'
    end
  end

  def update
    @gl_mapping = GLMapping.find(params[:id])
    if @gl_mapping.update_attributes(gl_mapping_params)
      flash[:success] = "Mapping successfully updated!"
      redirect_to accountingpanel_url
    else
      render :edit
    end
  end

  def destroy
    @gl_mapping = GLMapping.find(params[:id])
    if @gl_mapping
      @gl_mapping.destroy
    end
    redirect_to accountingpanel_url
  end

  private

  def gl_mapping_params
    params.require(:gl_mapping).permit(:transaction_type_id, :debit_account_id, :credit_account_id)
  end

end