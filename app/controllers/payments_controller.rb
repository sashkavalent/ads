class PaymentsController < ApplicationController
  load_and_authorize_resource

  def index
  end
  def create

    if (hash_key = HashKey.find_by_value(params['hash_key']))

      hash_key.destroy
      @payment = Payment.new(wallet_id: current_user.wallet.id,
        amount: Payment.coin_number)

      current_user.wallet.balance += @payment.amount
      current_user.wallet.save

      if @payment.save
        flash[:notice] = 'Payment was accepted.'
        params[:payment] = nil
      else
        flash[:error] = @payment.errors.full_messages.join('. ')
      end

    else
      flash[:error] = 'Ooooops... Entered hash key is wrond. Try again.'
    end

    redirect_to new_payment_path

  end

  def new
  end

end
