class UsersController < ApplicationController
  load_and_authorize_resource
  def index
    @users = User.paginate(:page => params[:page], :per_page => 12)
  end
  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    flash[:notice] = "Account #{@user.email} was deleted"
    redirect_to '/all_users'
  end
  def show
    @ad = current_user.ads.build if user_signed_in?
    if current_user.admin?
      @ads = Ad.where(state: "posting").paginate(:page => params[:page], :per_page => 5)
      @users = @ads.map {|ad| User.find_by_id(ad.user_id)}.uniq
    else
      @ads = Ad.where(user_id: current_user.id).paginate(:page => params[:page], :per_page => 5)
    end
  end
end
