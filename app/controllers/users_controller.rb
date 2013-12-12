class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.paginate(:page => params[:page], :per_page => Ad.per_page_big)
  end

  def destroy
    @user.destroy
    respond_with(@user)
  end

  def show
    @ads = @user.profile_ads(current_user).
      paginate(:page => params[:page], :per_page => Ad.per_page_small)
  end

  def make_admin
    @user.role = :admin
    @user.save
    respond_with(@user, :location => @user)
  end

end
