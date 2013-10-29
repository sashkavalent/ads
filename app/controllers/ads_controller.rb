class AdsController < ApplicationController
  load_and_authorize_resource

  def create

    @ad = current_user.ads.build(params[:ad])
    if @ad.save
      flash[:notice] = t(:added, scope: [:ads])
    else
      flash[:error] = @ad.errors.full_messages.join('. ')
    end
    redirect_to(:back)

  end

  def destroy

    @ad.destroy
    flash[:notice] = t(:deleted, scope: [:ads])
    redirect_to(:back)

  end

  def index

    @ads = Ad.sorted(params)
    @ads = @ads.paginate(:page => params[:page], :per_page => 8)
    @ad_types = AdType.all
    @default_created_id = params[:created_id]
    @default_ad_type_id = params[:ad_type_id]

  end

  def update

    @ad.attributes = params[:ad]
    @ad.save
    redirect_to profile_path

  end

  def show
    @ad_types = AdType.all
    session[:return_to] ||= request.referer
  end

  def change_state

    @ad.public_send(params[:state_event])
    @ad.save
    flash[:notice] = t(:status_changed, scope: [:ads])
    redirect_to(:back)

  end

end
