class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.paginate(:page => params[:page], :per_page => 12)
  end

  def destroy

    @user.destroy
    flash[:notice] = t(:deleted, scope: [:users], user: @user.email)
    redirect_to users_path

  end

  def show

    @ad = current_user.ads.build if user_signed_in?

    if current_user.role.admin?
      @ads = Ad.where(state: 'posting').paginate(:page => params[:page], :per_page => 5)
    else
      @ads = Ad.where(user_id: current_user.id).paginate(:page => params[:page], :per_page => 5)
    end

    @ad_types = AdType.all

  end

  def update

    if current_user.role.admin?
      @user.role = :admin
    end
    @user.save
    redirect_to(:back)

  end
end
