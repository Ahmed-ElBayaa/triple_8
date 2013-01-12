class StoreController < ApplicationController

  skip_before_filter :authenticate_user!
  	
  def index
  	@search = Classified.search(params[:search])
    @classifieds = @search.paginate per_page: 10, page: params[:page],
          order: "created_at DESC"

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @classifieds }
    end
  end

end
