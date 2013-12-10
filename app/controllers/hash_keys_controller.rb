class HashKeysController < ApplicationController
  @@key_number = 10
  load_and_authorize_resource

  def create
    @@key_number.times do

      @hash_key = HashKey.new
      if @hash_key.save
        flash[:notice] = 'Hash keys were added.'
        params[:hash_key] = nil
      else
        flash[:error] = @hash_key.errors.full_messages.join('. ')
      end

    end

    redirect_to root_path
  end


end
