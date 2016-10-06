class MemberProfilesController < ApplicationController
  #filter_resource_access :collection => [[:generate, :index], :index, :delete_contact]
  #filter_resource_access :additional_collection => { :generate => :read }
  #filter_access_to :all, :except => :delete_contact 
  #filter_access_to
  filter_resource_access
  def index
    @member_profile = MemberProfile.findByUserId(current_user.id)
    if @member_profile.nil?
      @member_profile = new
    end
  end

  def show
    @member_profile = MemberProfile.find(params[:id])
    @profile_contacts = @member_profile.profile_contacts
  end

  def new
    @member_profile = MemberProfile.new
    @member_profile.user_id = current_user.id
    @member_profile
  end

  def edit
    @member_profile = MemberProfile.find(params[:id])
  end

  def create
    @member_profile = MemberProfile.new(profile_params)
    @member_profile.user_id = current_user.id

    if @member_profile.save

      populate_attribs

      flash[:info] = "Profile created."
      redirect_to @member_profile
    else
      render 'new'
    end
  end

  def update
    @member_profile = MemberProfile.find(params[:id])
    if @member_profile.update_attributes(profile_params)

      populate_attribs

      flash[:success] = "Profile successfully updated!"
      redirect_to @member_profile
    else
      render :edit
    end
  end

  def destroy
    @member_profile = MemberProfile.find(params[:id])
    if @member_profile
      @member_profile.destroy
    end
    redirect_to member_profile_url
  end

  def delete_sticker
    contact = ProfileSticker.find(params[:id])
    member_profile = MemberProfile.find(contact.member_profile_id)
    contact.destroy
    redirect_to member_profile
  end

  def delete_contact
    contact = ProfileContact.find(params[:contact_id])
      logger.info "Searching for profile with id --> "+contact.member_profile_id.to_s
    member_profile = MemberProfile.find(contact.member_profile_id)
    contact.destroy
    redirect_to member_profile
  end

  def delete_profile_car
    profilecar = ProfileCar.find(params[:id])
    member_profile = MemberProfile.find(profilecar.member_profile_id)
    profile_car_photos = profilecar.profile_car_photos
    if(!profile_car_photos.nil? && profile_car_photos.size > 0)
      profile_car_photos.destroy_all
    end
    profilecar.destroy
    redirect_to member_profile
  end

  private

  def populate_attribs

    if(!params[:member_profile].nil? && !params[:member_profile]['profile_contacts'].nil?)
      phone_no = params[:member_profile]['profile_contacts']['phone_no']
      email_address = params[:member_profile]['profile_contacts']['email_address']
      postal_address = params[:member_profile]['profile_contacts']['postal_address']
      physical_address = params[:member_profile]['profile_contacts']['physical_address']

      if( !isnillorempty(phone_no) && !isnillorempty(email_address) && !isnillorempty(postal_address) )
        profileContact = ProfileContact.new
        profileContact.phone_no = phone_no
        profileContact.email_address = email_address
        profileContact.postal_address = postal_address
        profileContact.physical_address = physical_address
        profileContact.member_profile_id = @member_profile.id
        profileContact.save!
      end
    end

    if(!params[:member_profile].nil? && !params[:member_profile]['profile_car'].nil?)

      vehicle_model_id = params[:member_profile]['profile_car']['vehicle_model_id']
      regNo = params[:member_profile]['profile_car']['regNo']
      color = params[:member_profile]['profile_car']['color']
      petname = params[:member_profile]['profile_car']['petname']

      if( !isnillorempty(vehicle_model_id) && !isnillorempty(regNo) && !isnillorempty(color) && !isnillorempty(petname) )

        profile_car = ProfileCar.new
        profile_car.vehicle_model_id = vehicle_model_id
        profile_car.regNo = regNo
        profile_car.color = color
        profile_car.petname = petname
        profile_car.member_profile_id  = @member_profile.id

        profile_car.save!

        c = 0
        params[:profile_car_photo]['avatar'].each do |a|
          profile_car_photo = ProfileCarPhoto.new
          profile_car_photo.avatar = a
          profile_car_photo.profile_car_id = profile_car.id
          profile_car_photo.active = true
          if(c==0)
            profile_car_photo.defaultimg = true
          elsif
          profile_car_photo.defaultimg = false
          end
          profile_car_photo.save!
          c = c+1
        end

      end

    end

    if(!params[:member_profile].nil? && !params[:member_profile]['profile_sticker'].nil?)
      number = params[:member_profile]['profile_sticker']['number']
      sticker_status = params[:member_profile]['profile_sticker']['sticker_status']
      if( !isnillorempty(number) )
        sticker = ProfileSticker.new
        sticker.member_profile_id  = @member_profile.id
        sticker.number = number
        
        if( !isnillorempty(sticker_status) )
          sticker.sticker_status = sticker_status
        end
        
        sticker.save!
      end
    end

  end

  private

  def isnillorempty(myString)
    myString.nil? || myString.empty?
  end

  private

  def profile_params
    params.require(:member_profile).permit(:user_id, :status)
  end
end