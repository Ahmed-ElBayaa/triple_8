class AuthenticationsController < ApplicationController
	skip_before_filter :authenticate_user!

  def edit
  end

  def update
  	@user = User.new(name: session[:auth][:name],
         email: params[:email], password: params[:email])

  	respond_to do |format|
  		if @user.save
	  		 @user.authentications.create(provider: session[:auth][:provider],
	  		   uid:session[:auth][:uid], oauth_token: session[:auth][:oauth_token]) 
	      
	      session[:auth] = nil
	      flash.notice = I18n.t('const.signed_in_successfully')
      	sign_in @user
      	format.html { redirect_to home_path }

	  	else

	  		format.html { render action: "edit" }
	      format.json { render json: @user.errors, status: :unprocessable_entity }
	      
	    end
  	end

  end

end
