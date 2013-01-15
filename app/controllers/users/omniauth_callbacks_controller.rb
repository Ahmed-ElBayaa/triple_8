class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def passthru

	  render :file => "#{Rails.root}/public/404.html",
       :status => 404, :layout => false
	  # Or alternatively,
	  # raise ActionController::RoutingError.new('Not Found')
	end

	# def facebook
 #    # You need to implement the method below in your model (e.g. app/models/user.rb)
 #    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

 #    if @user.persisted?
 #      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
 #      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
 #    else
 #      session["devise.facebook_data"] = request.env["omniauth.auth"]
 #      redirect_to new_user_registration_url
 #    end
 #  end

  def all
    auth = request.env["omniauth.auth"]
    method_name = "from_omniauth_#{auth.provider}"
    user = User.send(method_name, auth)
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