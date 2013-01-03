class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :must_be_admin

  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to_back exception.message
  end

  def redirect_to_back msg=""
  	if !request.env["HTTP_REFERER"].blank? and
  	 request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to :back, notice: msg
    else
      redirect_to root_url, notice: msg
    end
  end

  def must_be_admin
  	if current_user
  		unless current_user.type == 'Admin'
  			redirect_to_back "you don't have permission to access this page"
  		end
  	else
			redirect_to new_user_session_path, notice: "Please sign in"
		end
  end

end
