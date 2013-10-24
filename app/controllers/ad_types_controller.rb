class AdTypesController < ApplicationController
  load_and_authorize_resource

  def create

    @ad_type = AdType.new(params[:ad_type])

    if @ad_type.save
      flash[:notice] = 'Type was added'
    else
      flash[:error] = @ad_type.errors.full_messages.join('. ')
    end

    redirect_to(:back)
  end

  def destroy

    if Ad.where(ad_type_id: @ad_type.id).blank?
      @ad_type.destroy
      flash[:notice] = 'Type was deleted'
    else
      flash[:error] = 'Cannot delete this type. There are its ads.'
    end

    redirect_to(:back)
  end

  def index
  end
end
