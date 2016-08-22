class ActivationsController < ApplicationController
  #before_filter :require_no_user
  def create
    @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
    raise Exception if @user.active?

    if @user.activate!
      role = Role.find_by_title('user')
      if(role.nil?)
        role = Role.new
        role.title = 'user'
      end
      @user.roles  << role
      @user.save
      flash[:success] = "Your account has been activated!"
      @user.deliver_welcome!
      UserSession.create(@user, false) # Log user in manually
      redirect_to root_url
    else
      render :action => :new
    end
  end
end
