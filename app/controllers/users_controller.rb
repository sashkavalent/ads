class UsersController < ApplicationController
  def users
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end
  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    flash[:notice] = "Account #{@user.email} was deleted"
    redirect_to '/allusers'
  end
end
