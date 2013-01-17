class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticity_token, only: [:google]

	def passthru

	  render :file => "#{Rails.root}/public/404.html",
       :status => 404, :layout => false
	end

  def all
    user = User.from_omniauth_provider(request.env["omniauth.auth"])
    if user
      if user.persisted?
        flash.notice = I18n.t('const.signed_in_successfully')
        sign_in_and_redirect user
      else
        session["devise.user_attributes"] = user.attributes
        redirect_to new_user_registration_url
      end
    else
      auth = request.env["omniauth.auth"]
      required_auth = {}
      required_auth[:provider] = auth.provider
      required_auth[:uid] = auth.uid
      required_auth[:name] = auth.info.name     
      required_auth[:oauth_token] = auth.credentials.token
      session[:auth] = required_auth
      redirect_to edit_auth_path
    end    
  end

  # def twitter
  #   auth = request.env["omniauth.auth"]

  #   authentication = Authentication.find_by_provider_and_uid(
  #     auth.provider, auth.uid)

  #   if authentication
  #     authentication.oauth_token = auth.credentials.token
  #     authentication.save
  #     flash.notice = I18n.t('const.signed_in_successfully')
  #     sign_in_and_redirect authentication.user
  #   else      
  #     required_auth = {}
  #     required_auth[:provider] = auth.provider
  #     required_auth[:uid] = auth.uid
  #     required_auth[:name] = auth.info.name     
  #     required_auth[:oauth_token] = auth.credentials.token
  #     session[:auth] = required_auth
  #     redirect_to edit_auth_path
  #   end
  # end

  alias_method :facebook, :all
  alias_method :linkedin, :all
  alias_method :google, :all
  alias_method :yahoo, :all
  alias_method :twitter, :all
  alias_method :windowslive, :all

end