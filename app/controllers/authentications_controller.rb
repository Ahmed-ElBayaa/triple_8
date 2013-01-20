class AuthenticationsController < ApplicationController
	skip_before_filter :authenticate_user!

  def edit
  end

  def update
  	@user = User.new(session[:user])
    @user.email = params[:email]
    @user.authentications.build(session[:auth]) 
  	respond_to do |format|
  		if @user.save	  		
        session[:user] = nil	      
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
