class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.paginate(:page => params[:page], :per_page => 12)
  end

  def destroy

    @user.destroy
    flash[:notice] = t(:deleted, scope: [:users], user: @user.name)
    redirect_to users_path

  end

  def show

    if params['id'] == current_user.id.to_s

      if current_user.role.admin?
        @ads = Ad.where(state: 'posting').paginate(:page => params[:page], :per_page => 5)
      else
        @ads = Ad.where(user_id: params['id']).
          paginate(:page => params[:page], :per_page => 5)
        @ad = current_user.ads.build(params[:ad]) if user_signed_in?
        @ad_types = AdType.all
        @places = Place.all
        @sections = Section.all
        @currencies = Currency.all
      end

    else

      @ads = Ad.where(state: 'published', user_id: params['id']).
        paginate(:page => params[:page], :per_page => 5)

    end

    @user = User.find_by_id(params['id'])

  end

  def update

    if current_user.role.admin?
      @user.role = :admin
    end
    @user.save
    redirect_to(:back)

  end
end
