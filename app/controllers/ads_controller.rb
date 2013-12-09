class AdsController < ApplicationController
  load_and_authorize_resource

  def create

    @ad.keywords = get_keywords_from_params
    current_user.ads << @ad

    if @ad.save
      flash[:notice] = t(:added, scope: [:ads])
      params[:ad] = nil
    else
      flash[:error] = @ad.errors.full_messages.join('. ')
    end

    redirect_to user_path(current_user, :ad => params[:ad])

  end

  def destroy
    @ad.destroy
    flash[:notice] = t(:deleted, scope: [:ads])
    redirect_to session.delete(:return_to)
  end

  def index

    ad_type_id = params['ad_type_id'].blank? ? nil : params['ad_type_id']
    order = params['created_at'] || 'created_at DESC'
    @ads = Ad.search(params['key_word'],
      :sql => {:include => [:user, :ad_type, :photos] },
      :conditions => {:ad_type_id => ad_type_id, :state => :published},
      :order => order, :page => params[:page], :per_page => 6)
    @ad_types = AdType.all

  end

  def update

    @ad.keywords = get_keywords_from_params
    @ad.attributes = params[:ad]
    @ad.save
    redirect_to @ad

  end

  def show

    session[:return_to] ||= request.referer

    @ad_types = AdType.all
    if can? :create, Comment
      @comment = current_user.comments.build(params[:comment])
      @comment.ad_id = params[:id]
    end

  end

  def edit

    @ad_types = AdType.all
    @places = Place.all
    @sections = Section.all
    @currencies = Currency.all

  end

  def change_state

    @ad.public_send(params[:state_event])
    @ad.save
    flash[:notice] = t(:status_changed, scope: [:ads])
    redirect_to(:back)

  end

  private

  def get_keywords_from_params

    params['keywords'].split(/[,;#.-] */).
      map { |keyword| Keyword.find_or_create_by_name(keyword) }

  end


end
