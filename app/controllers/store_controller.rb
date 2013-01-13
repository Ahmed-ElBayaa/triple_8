class StoreController < ApplicationController

  skip_before_filter :authenticate_user!
  	
  def index

    params[:order_by] ||= 'created_at DESC'
  	@search = Classified.search(params[:search])
    @classifieds = @search.paginate per_page: 10, page: params[:page],
          order: params[:order_by]

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @classifieds }
    end
  end

end
