class UserSessionsController < ApplicationController
  filter_resource_access
  def new
    @user_session = UserSession.new
  end

  def create
    session_params = params.require(:user_session).permit!
    @user_session = UserSession.new(session_params)
    if @user_session.save
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    @user_session = UserSession.find
    if @user_session
      @user_session.destroy
    end
    redirect_to root_url, info: 'Successfully logged out.'
  end

end
