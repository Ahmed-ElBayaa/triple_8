class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_i18n_locale_from_params
  before_filter :authenticate_user!

  def redirect_to_back msg=""
  	if !request.env["HTTP_REFERER"].blank? and
  	 request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to :back, notice: msg
    else
      redirect_to root_path, notice: msg
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
    puts "*"*50
		unless current_user.type == 'Admin'
			redirect_to_back(
        I18n.t("application.messages.insufficient_privilage"))
		end
  end

end
