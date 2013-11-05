class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    authenticate
  end

  def vkontakte
    authenticate
  end

  def google_oauth2
    authenticate
  end

  private

    def authenticate

      @user = User.find_for_oauth request.env["omniauth.auth"]
      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success",
          :kind => @user.provider
        sign_in_and_redirect @user, :event => :authentication
      else
        flash[:notice] = I18n.t(:authentication_error,
          :scope[:omniauth_callbacks])
        redirect_to root_path
      end

    end

end
