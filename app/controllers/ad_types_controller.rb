class AdTypesController < ApplicationController
  load_and_authorize_resource

  def create

    @ad_type = AdType.create(params[:ad_type])

    if @ad_type.save
      flash[:notice] = t(:added, scope: [:ad_types])
    else
      flash[:error] = @ad_type.errors.full_messages.join('. ')
    end

    redirect_to(:back)

  end

  def destroy

    if Ad.where(ad_type_id: @ad_type.id).blank?
      @ad_type.destroy
      flash[:notice] = t(:deleted, scope: [:ad_types])
    else
      flash[:error] = t(:cannot_delete, scope: [:ad_types])
    end

    redirect_to(:back)
  end

  def index
    @ad_type = AdType.new()
  end

end
