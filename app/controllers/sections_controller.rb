class SectionsController < ApplicationController
  load_and_authorize_resource

  def create
    @section.save
    @sections = Section.all
    respond_with(@section, :location => :new_section)
  end

  def destroy
    @section.destroy
    respond_with(@section, :location => :new_section)
  end

  def new
    @sections = Section.all
  end

end
