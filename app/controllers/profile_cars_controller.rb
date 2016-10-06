class ProfileCarsController < ApplicationController
  #before_action :set_post_attachment, only: [:show, :edit, :update, :destroy]

  # GET /post_attachments
  # GET /post_attachments.json

  filter_resource_access
  def index
    @profile_cars = ProfileCar.all
  end

  # GET /post_attachments/1
  # GET /post_attachments/1.json
  def show
    @profile_car = ProfileCar.find(params[:id])
  end

  # GET /post_attachments/new
  def new
    @profile_car = ProfileCar.new
  end

  # GET /post_attachments/1/edit
  def edit
    @profile_car = ProfileCar.find(params[:id])
  end

  # POST /post_attachments
  # POST /post_attachments.json
  def create
    @profile_car = ProfileCar.new(post_attachment_params)

    respond_to do |format|
      if @profile_car.save
        flash[:success] = 'Car was successfully saved.'
        format.html { redirect_to @profile_car }
        format.json { render :show, status: :created, location: @profile_car }
      else
        format.html { render :new }
        format.json { render json: @profile_car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_attachments/1
  # PATCH/PUT /post_attachments/1.json
  def update
    @profile_car = ProfileCar.find(params[:id])
    respond_to do |format|
      if @profile_car.update(post_attachment_params)
        flash[:success] = 'Car was successfully updated.'
        format.html { redirect_to @profile_car}
        format.json { render :show, status: :ok, location: @profile_car }
      else
        format.html { render :edit }
        format.json { render json: @profile_car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_attachments/1
  # DELETE /post_attachments/1.json
  def destroy
    @profile_car = ProfileCar.find(params[:id])
    profile_car_photos = @profile_car.profile_car_photos
    if(!profile_car_photos.nil? && profile_car_photos.size > 0)
      profile_car_photos.destroy_all
    end
    @profile_car.destroy
    respond_to do |format|
      flash[:success] = 'Car was successfully deleted.'
      format.html { redirect_to MemberProfile.find(@profile_car.member_profile_id) }
      format.json { head :no_content }
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_attachment_params
    params.require(:product).permit(:product_id, :avatar)
  end
end