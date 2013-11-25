class CurrenciesController < ApplicationController
  load_and_authorize_resource

  def create

    @currency = Currency.new(params[:currency])

    if @currency.save
      flash[:notice] = t(:added, scope: [:currencies])
      params[:currency] = nil
    else
      flash[:error] = @currency.errors.full_messages.join('. ')
    end

    redirect_to(currencies_path, :currency => params[:currency])

  end

  def destroy

    if Ad.where(currency_id: @currency.id).blank?
      @currency.destroy
      flash[:notice] = t(:deleted, scope: [:currencies])
    else
      flash[:error] = t(:cannot_delete, scope: [:currencies])
    end

    redirect_to(:back)
  end

  def index
    @currency = Currency.new(params[:currency])
  end

end
