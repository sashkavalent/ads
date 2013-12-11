class SubsectionsController < ApplicationController
  load_and_authorize_resource

  def create
    @subsection.section_id = params[:section_id]
    @subsection.save
    @subsections = Subsection.where(section_id: params[:section_id])
    respond_with(@subsection.section, @subsection,
      :location => :new_section_subsection)
  end

  def destroy
    @subsection.destroy
    respond_with(@subsection.section, @subsection,
      :location => new_section_subsection_path(@subsection.section))
  end

  def new
    @subsections = Subsection.where(section_id: params[:section_id])
    @subsection.section_id = params[:section_id]
  end

end
