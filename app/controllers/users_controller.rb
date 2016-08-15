class UsersController < ApplicationController
  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save_without_session_maintenance
      @user.deliver_activation_instructions!
      flash[:info] = "Your account has been created. Please check your e-mail - #{@user.email} - for your account activation instructions!"
      redirect_to email_sent_url
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :remember_me)
  end
end
