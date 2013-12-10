class SubsectionsController < ApplicationController
  load_and_authorize_resource

  def create

    @subsection = Subsection.new(params[:subsection])
    @subsection.section_id = params[:section_id]

    if @subsection.save
      flash[:notice] = 'Subsection was added.'
      params[:subsection] = nil
    else
      flash[:error] = @subsection.errors.full_messages.join('. ')
    end

    redirect_to sections_path

  end

  def destroy

    if Ad.where(subsection_id: @subsection.id).blank?
      @subsection.destroy
      flash[:notice] = t(:deleted, scope: [:sections])
    else
      flash[:error] = t(:cannot_delete, scope: [:sections])
    end

    redirect_to(:back)
  end

  def index
    @subsections = Subsection.where(section_id: params[:section_id])
    @subsection = Subsection.new(params[:subsection])
    @subsection.section_id = params[:section_id]
  end

end
