class AdsController < ApplicationController
  load_and_authorize_resource

  before_filter :load_ad, :only => [:destroy, :update, :show, :change_state]

  def create
    @ad = current_user.ads.build(params[:ad])
    if @ad.save
      flash[:notice] = 'Ad is created'
    else
      flash[:error] = @ad.errors.full_messages.join('. ')
    end
    redirect_to(:back)
  end

  def destroy
    @ad.destroy
    flash[:notice] = 'Ad is deleted'
    redirect_to(:back)
  end

  def index
    @ads = Ad.where(state: 'published').paginate(:page => params[:page], :per_page => 8)
    render '_ads'
  end

  def update
    @ad.attributes = params[:ad]
    @ad.save
    redirect_to profile_path
  end

  def show
    session[:return_to] ||= request.referer
  end

  def change_state
    @ad.public_send(params[:state_event])
    @ad.save
    flash[:notice] = 'Status of ad was changed'
    redirect_to(:back)
  end

  protected

    def load_ad
      @ad = Ad.find_by_id(params[:id])
    end

end
