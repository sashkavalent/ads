class PlacesController < ApplicationController
  load_and_authorize_resource

  def create
    @place.save
    @places = Place.all
    respond_with(@place, :location => :new_place)
  end

  def destroy
    @place.destroy
    respond_with(@place, :location => :new_place)
  end

  def new
    @places = Place.all
  end

end
