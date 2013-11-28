class PlacesController < ApplicationController
  load_and_authorize_resource

  def create

    @place = Place.new(params[:place])

    if @place.save
      flash[:notice] = t(:added, scope: [:places])
      params[:place] = nil
    else
      flash[:error] = @place.errors.full_messages.join('. ')
    end

    redirect_to places_path
  end

  def destroy

    if Ad.where(place_id: @place.id).blank?
      @place.destroy
      flash[:notice] = t(:deleted, scope: [:places])
    else
      flash[:error] = t(:cannot_delete, scope: [:places])
    end

    redirect_to(:back)
  end

  def index
    @place = Place.new(params[:place])
  end

end
