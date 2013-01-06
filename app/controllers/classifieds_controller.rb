class ClassifiedsController < ApplicationController
  skip_before_filter :must_be_admin
  before_filter :authorize, only: [:new, :create]

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
    must_be_owned
    @sub_categories = Category.find(@classified.main_category_id).children
    @classified.complete_attachments_number
  end

  # POST /classifieds
  # POST /classifieds.json
  def create
    @classified = Classified.new(params[:classified])
    @classified.user_id = current_user.id
    respond_to do |format|
      if @classified.save
        format.html { redirect_to @classified,
         notice: I18n.t('application.messages.successfully_created', model: 'classified') }
        format.json { render json: @classified, status: :created, location: @classified }
      else
        @classified.complete_attachments_number
        main_category = Category.find_by_id(params[:classified][:main_category_id])
        @sub_categories = main_category.nil? ? nil : main_category.children       
        format.html { render action: "new" }
        format.json { render json: @classified.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /classifieds/1
  # PUT /classifieds/1.json
  def update
    @classified = Classified.find_by_identifier(params[:id])
    must_be_owned
    respond_to do |format|
      if @classified.update_attributes(params[:classified])
        format.html { redirect_to @classified,
          notice: I18n.t('application.messages.successfully_updated', model: 'classified') }
        format.json { head :ok }
      else
        @classified.complete_attachments_number
        @sub_categories = Category.find(@classified.main_category_id).children
        format.html { render action: "edit" }
        format.json { render json: @classified.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classifieds/1
  # DELETE /classifieds/1.json
  def destroy
    @classified = Classified.find_by_identifier(params[:id])
    must_be_owned
    @classified.destroy

    respond_to do |format|
      format.html { redirect_to classifieds_url }
      format.json { head :ok }
    end
  end

  def change_sub_categories
    main_category = Category.find(params[:main_category]);
    sub_categories = main_category.children
    respond_to do |format|
      format.js { @sub_categories = sub_categories }
    end
  end

  private

  def must_be_owned
    unless @classified.user = current_user
      redirect_to_back I18n.t("application.messages.insufficient_privilage")
    end
  end

end
