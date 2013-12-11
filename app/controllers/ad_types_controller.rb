class AdTypesController < ApplicationController
  load_and_authorize_resource

  def create
    @ad_type.save
    @ad_types = AdType.all
    respond_with(@ad_type, :location => :new_ad_type)
  end

  def destroy
    @ad_type.destroy
    respond_with(@ad_type, :location => :new_ad_type)
  end

  def new
    @ad_types = AdType.all
  end

end
