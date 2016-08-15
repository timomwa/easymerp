class AdministrationController < ApplicationController
  filter_resource_access
  def index
  end

  def listusers
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end

  def toggleactive
    @user = User.find(params[:id])
    if(@user.nil? == true)
      flash[:error] = "Can't find user!"
    else
      @user.active = !@user.active?
      if(@user.save)
        flash[:success] = "The user with the email #{@user.email} was" + (@user.active? ? "Activated" : "Deactivated")
      else
        flash[:error] = "Could not " +(@user.active? ? "Activate" : "Deactivate") + " user";
      end
    end
    redirect_to listusers_url
  end

  def toggleapprove
    @user = User.find(params[:id])
    if(@user.nil? == true)
      flash[:error] = "Can't find user!"
    else
      @user.approved = !@user.approved?
      if(@user.save)
        flash[:success] = "The user with the email #{@user.email} was " + (@user.approved? ? "Approved" : "Disapproved")
      else
        flash[:error] = "Could not " +(@user.approved? ? "approve" : "disapprove") + "account";
      end
    end
    redirect_to listusers_url
  end

  def toggleconfirm
    @user = User.find(params[:id])
    if(@user.nil? == true)
      flash[:error] = "Can't find user!"
    else
      @user.confirmed = !@user.confirmed?
      if(@user.save)
        flash[:success] = "The user with the email #{@user.email} was " + (@user.confirmed? ? "confirmed" : "unconfirmed")
      else
        flash[:error] = "Could not " +(@user.confirmed? ? "confirm" : "unconfirm") + "  account";
      end
    end
    redirect_to listusers_url
  end

end
