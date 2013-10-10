class UsersController < ApplicationController
  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end
  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    flash[:notice] = "Account #{@user.email} was deleted"
    redirect_to '/allusers'
  end
  def show
    @ad = current_user.ads.build if user_signed_in?
    @ads = Ad.where(user_id: current_user.id).paginate(:page => params[:page], :per_page => 10)
  end
end
