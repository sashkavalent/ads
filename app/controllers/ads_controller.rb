class AdsController < ApplicationController
  load_and_authorize_resource

  def create

    @ad.keywords = get_keywords_from_params
    current_user.ads << @ad
    @ad.save
    load_dropdown_collections
    load_keywords_and_hints
    respond_with(@ad, :location => @ad)

  end

  def destroy
    @ad.destroy
    respond_with @ad
  end

  def index

    ad_type_id = params['ad_type_id'].blank? ? nil : params['ad_type_id']
    order = params['created_at'] || 'created_at DESC'
    @ads = Ad.search(params['key_word'],
      :sql => {:include => [:user, :ad_type, :photos] },
      :conditions => {:ad_type_id => ad_type_id, :state => :published},
      :order => order, :page => params[:page], :per_page => Ad.per_page_small)
    @ad_types = AdType.all

  end

  def update

    @ad.keywords = get_keywords_from_params
    @ad.attributes = params[:ad]
    @ad.save
    load_dropdown_collections
    load_keywords_and_hints
    respond_with(@ad, :location => @ad)

  end

  def show

    load_keywords
    session[:return_to] ||= request.referer
    @ad_types = AdType.all

    if can? :create, Comment
      @comment = current_user.comments.build(params[:comment])
      @comment.ad_id = params[:id]
    end

  end

  def edit
    load_dropdown_collections
    load_keywords_and_hints
  end

  def new
    load_dropdown_collections
    load_keywords_hint
  end

  def change_state

    @ad.public_send(params[:state_event])
    @ad.save
    flash[:notice] = t(:status_changed, scope: [:ads])
    redirect_to(:back)

  end

  private

  def load_keywords_and_hints
    load_keywords
    load_keywords_hint
  end

  def load_keywords
    gon.watch.keywords = @ad.keywords
  end

  def load_keywords_hint
    gon.keywords_hint = Keyword.all
  end

  def get_keywords_from_params

    if params['tags']
      params['tags'].split(',').
        map { |keyword| Keyword.find_or_create_by_name(keyword) }
    else
      return []
    end

  end

  def load_dropdown_collections

    @ad_types = AdType.all
    @places = Place.all
    @sections = Section.all
    @currencies = Currency.all

  end

end
