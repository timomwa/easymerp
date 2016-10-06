class ImagesController < ApplicationController
  #before_action :set_post_attachment, only: [:show, :edit, :update, :destroy]

  # GET /post_attachments
  # GET /post_attachments.json

  filter_resource_access
  
  def index
    @images = Image.all
  end

  # GET /post_attachments/1
  # GET /post_attachments/1.json
  def show
    @images = Image.find(params[:id])
  end

  # GET /post_attachments/new
  def new
    @image = Image.new
  end

  # GET /post_attachments/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /post_attachments
  # POST /post_attachments.json
  def create
    @image = Image.new(post_attachment_params)

    respond_to do |format|
      if @image.save
        flash[:success] = 'Image was successfully saved.'
        format.html { redirect_to @image }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_attachments/1
  # PATCH/PUT /post_attachments/1.json
  def update
    @image = Image.find(params[:id])
    respond_to do |format|
      if @image.update(post_attachment_params)
        flash[:success] = 'Image was successfully updated.'
        format.html { redirect_to @image}
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_attachments/1
  # DELETE /post_attachments/1.json
  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    respond_to do |format|
      flash[:success] = 'Image was successfully deleted.'
      format.html { redirect_to Product.find(@image.product_id) }
      format.json { head :no_content }
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_attachment_params
    params.require(:product).permit(:product_id, :avatar)
  end
end