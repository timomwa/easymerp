class ProfileStickersController < ApplicationController
  #before_action :set_post_attachment, only: [:show, :edit, :update, :destroy]
  
    # GET /post_attachments
    # GET /post_attachments.json
  
    filter_resource_access
    
    def index
      @profile_stickers = ProfileSticker.all
    end
  
    # GET /post_attachments/1
    # GET /post_attachments/1.json
    def show
      @profile_sticker = ProfileSticker.find(params[:id])
    end
  
    # GET /post_attachments/new
    def new
      @profile_sticker = ProfileSticker.new
    end
  
    # GET /post_attachments/1/edit
    def edit
      @profile_sticker = ProfileSticker.find(params[:id])
    end
  
    # POST /post_attachments
    # POST /post_attachments.json
    def create
      @profile_sticker = ProfileSticker.new(post_attachment_params)
  
      respond_to do |format|
        if @profile_sticker.save
          flash[:success] = 'Sticker was successfully saved.'
          format.html { redirect_to @profile_sticker }
          format.json { render :show, status: :created, location: @profile_sticker }
        else
          format.html { render :new }
          format.json { render json: @profile_sticker.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /post_attachments/1
    # PATCH/PUT /post_attachments/1.json
    def update
      @profile_sticker = ProfileSticker.find(params[:id])
      respond_to do |format|
        if @profile_sticker.update(post_attachment_params)
          flash[:success] = 'Image was successfully updated.'
          format.html { redirect_to @profile_sticker}
          format.json { render :show, status: :ok, location: @profile_sticker }
        else
          format.html { render :edit }
          format.json { render json: @profile_sticker.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /post_attachments/1
    # DELETE /post_attachments/1.json
    def destroy
      @profile_sticker = ProfileSticker.find(params[:id])
      @profile_sticker.destroy
      respond_to do |format|
        flash[:success] = 'Image was successfully deleted.'
        format.html { redirect_to MemberProfile.find(@profile_sticker.member_profile_id) }
        format.json { head :no_content }
      end
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_attachment_params
      params.require(:product).permit(:product_id, :avatar)
    end
end