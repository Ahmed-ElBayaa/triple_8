class ClassifiedsController < ApplicationController
  # GET /classifieds
  # GET /classifieds.json
  def index
    @classifieds = Classified.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @classifieds }
    end
  end

  # GET /classifieds/1
  # GET /classifieds/1.json
  def show
    @classified = Classified.find_by_identifier(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @classified }
    end
  end

  # GET /classifieds/new
  # GET /classifieds/new.json
  def new
    @classified = Classified.new
    3.times {@classified.attachments.build}
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @classified }
    end
  end

  # GET /classifieds/1/edit
  def edit
    @classified = Classified.find_by_identifier(params[:id])
  end

  # POST /classifieds
  # POST /classifieds.json
  def create
    @classified = Classified.new(params[:classified])
    @classified.user_id = current_user.id
    respond_to do |format|
      if @classified.save
        format.html { redirect_to @classified, notice: 'Classified was successfully created.' }
        format.json { render json: @classified, status: :created, location: @classified }
      else
        format.html { render action: "new" }
        format.json { render json: @classified.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /classifieds/1
  # PUT /classifieds/1.json
  def update
    @classified = Classified.find_by_identifier(params[:id])

    respond_to do |format|
      if @classified.update_attributes(params[:classified])
        format.html { redirect_to @classified, notice: 'Classified was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @classified.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classifieds/1
  # DELETE /classifieds/1.json
  def destroy
    @classified = Classified.find_by_identifier(params[:id])
    @classified.destroy

    respond_to do |format|
      format.html { redirect_to classifieds_url }
      format.json { head :ok }
    end
  end
end
