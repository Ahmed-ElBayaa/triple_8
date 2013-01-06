class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_i18n_locale_from_params
  before_filter :must_be_admin

  def redirect_to_back msg=""
  	if !request.env["HTTP_REFERER"].blank? and
  	 request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to :back, notice: msg
    else
      redirect_to root_url, notice: msg
    end
  end

  protected

  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
      else
        flash.now[:notice] =
        "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def must_be_admin
  	if current_user
  		unless current_user.type == 'Admin'
  			redirect_to_back(
          I18n.t("application.messages.insufficient_privilage"))
  		end
  	else
			redirect_to new_user_session_path, 
        notice: I18n.t("application.messages.sign_in")
		end
  end

  def authorize
    unless current_user
      redirect_to new_user_session_path,
        notice: I18n.t("application.messages.sign_in")
    end
  end

end
