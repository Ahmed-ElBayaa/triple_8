class StoreController < ApplicationController

  # skip_before_filter :must_be_admin
  	
  def index
  	@search = Classified.search(params[:search])
    @classifieds = @search.all

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @classifieds }
    end
  end

end
