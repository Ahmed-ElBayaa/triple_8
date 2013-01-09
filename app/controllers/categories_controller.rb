class CategoriesController < ApplicationController
  before_filter :must_be_admin
  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.roots

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find_by_identifier(params[:id])
    @sub_categories = @category.children
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new
    @main_categories = Category.roots
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find_by_identifier(params[:id])
    @main_categories = Category.roots
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, 
          notice: I18n.t('application.messages.successfully_created', model:'category') }
        format.json { render json: @category, status: :created, location: @category }
      else
        @main_categories = Category.roots
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find_by_identifier(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: I18n.t('application.messages.successfully_updated',
           model:'category') }
        format.json { head :ok }
      else
        @main_categories = Category.roots
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find_by_identifier(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :ok }
    end
  end
end
