class SectionsController < ApplicationController
  load_and_authorize_resource

  def create

    @section = Section.new(params[:section])

    if @section.save
      flash[:notice] = t(:added, scope: [:sections])
      params[:section] = nil
    else
      flash[:error] = @section.errors.full_messages.join('. ')
    end

    redirect_to sections_path

  end

  def destroy

    if Ad.where(subsection_id: @section.subsections.map {|sub| sub.id}).blank?
      @section.destroy
      flash[:notice] = t(:deleted, scope: [:sections])
    else
      flash[:error] = t(:cannot_delete, scope: [:sections])
    end

    redirect_to(:back)
  end

  def index
    @section = Section.new(params[:section])
  end

end
