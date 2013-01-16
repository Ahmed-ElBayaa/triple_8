class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_before_filter :verify_authenticity_token, :only => [:google]

	def passthru

	  render :file => "#{Rails.root}/public/404.html",
       :status => 404, :layout => false
	end

  def all
    user = User.from_omniauth_provider(request.env["omniauth.auth"])
    if user.persisted?
      flash.notice = I18n.t('const.signed_in_successfully')
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  alias_method :twitter, :all
  alias_method :facebook, :all
  alias_method :linkedin, :all
  alias_method :windowslive, :all
  alias_method :google, :all
  alias_method :yahoo, :all

  
end