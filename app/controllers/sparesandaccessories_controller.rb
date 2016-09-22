class SparesandaccessoriesController < ApplicationController
  def index
    @products = Product.paginate(:page => params[:page], :per_page => 5)
  end
end