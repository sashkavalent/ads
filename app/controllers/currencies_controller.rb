class CurrenciesController < ApplicationController
  load_and_authorize_resource

  def create
    @currency.save
    @currencies = Currency.all
    respond_with(@currency, :location => :new_currency)
  end

  def destroy
    @currency.destroy
    respond_with(@currency, :location => :new_currency)
  end

  def new
    @currencies = Currency.all
  end

end
