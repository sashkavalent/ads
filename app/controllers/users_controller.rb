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
    if current_user.admin?
      @ads = Ad.where(state: "posting").paginate(:page => params[:page], :per_page => 10)
      @users = @ads.map {|ad| User.find_by_id(ad.user_id)}.uniq
    else
      @ads = Ad.where(user_id: current_user.id).paginate(:page => params[:page], :per_page => 10)
    end
  end
end
