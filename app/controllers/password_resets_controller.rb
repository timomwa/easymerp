class PasswordResetsController < ApplicationController
  #filter_resource_access
  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:info] = "Instructions to reset your password have been emailed to you. Please check your email -#{@user.email}- for the re-set link"
      redirect_to sign_in_url
    else
      flash[:warning] = "No user was found with that email address..."
      render :new
    end
  end

  def edit
    @user = User.find_by(perishable_token: params[:id])
  end

  def update
    @user = User.find_by(perishable_token: params[:id])
    if @user.update_attributes(password_reset_params)
      flash[:success] = "Password successfully updated! Now you can login"
      redirect_to sign_in_url
    else
      render :edit
    end
  end

  private

  def password_reset_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end