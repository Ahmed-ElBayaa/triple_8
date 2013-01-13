class ClassifiedsController < ApplicationController
  before_filter :index_for_admin_or_normal, only: [:index]

  # GET /classifieds
  # GET /classifieds.json
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

  def owned
    params[:order_by] ||= 'created_at DESC'
    @search = current_user.classifieds.search(params[:search])
    @classifieds = @search.paginate per_page: 10, page: params[:page],
          order: params[:order_by]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @classifieds }
    end
  end

  # GET /classifieds/1
  # GET /classifieds/1.json
  def show
    @classified = Classified.find_by_identifier(params[:id])
    if must_be_owned?
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @classified }
      end
    end  
  end

  # GET /classifieds/new
  # GET /classifieds/new.json
  def new
    @classified = Classified.new
    @classified.phone = current_user.phone
    @classified.email = current_user.email
    @classified.country = current_user.country
    3.times {@classified.attachments.build}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @classified }
    end
  end

  # GET /classifieds/1/edit
  def edit
    @classified = Classified.find_by_identifier(params[:id])

    if must_be_owned?
      @classified.complete_attachments_number
      main_category = Category.find_by_id(@classified.main_category_id)
      @sub_categories = main_category.nil? ? [] : main_category.children    
    end    
  end

  # POST /classifieds
  # POST /classifieds.json
  def create
    @classified = Classified.new(params[:classified])
    @classified.user_id = current_user.id

    respond_to do |format|
      if @classified.save
        format.html { 
          redirect_to @classified,
            notice: I18n.t('application.messages.successfully_created',
              model: 'classified') 
        }
        format.json { 
          render json: @classified, status: :created,
            location: @classified 
        }
      else
        @classified.complete_attachments_number
        main_category = Category.find_by_id(params[:classified][:main_category_id])
        @sub_categories = main_category.nil? ? [] : main_category.children
        format.html { render action: "new" }
        format.json { render json: @classified.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /classifieds/1
  # PUT /classifieds/1.json
  def update
    @classified = Classified.find_by_identifier(params[:id])
    if must_be_owned?
      respond_to do |format|
        if @classified.update_attributes(params[:classified])
          format.html { 
            redirect_to @classified,
              notice: I18n.t('application.messages.successfully_updated',
               model: 'classified') 
          }
          format.json { head :ok }
        else
          @classified.complete_attachments_number
          main_category = Category.find_by_id(@classified.main_category_id)
          @sub_categories = main_category.nil? ? [] : main_category.children
          format.html { render action: "edit" }
          format.json { 
            render json: @classified.errors,
             status: :unprocessable_entity 
          }
        end
      end  
    end    
  end

  # DELETE /classifieds/1
  # DELETE /classifieds/1.json
  def destroy
    @classified = Classified.find_by_identifier(params[:id])
    if must_be_owned?
      @classified.destroy

      respond_to do |format|
        format.html { redirect_to classifieds_url }
        format.json { head :ok }
      end
    end
  end

  def change_sub_categories
    main_category = Category.find_by_id(params[:main_category])
    @sub_categories = main_category.nil? ? [] : main_category.children
  end

  def change_sub_categories_for_search
    puts "LJ"*40
    main_category = Category.find_by_name(params[:main_category])
    @sub_categories = main_category.nil? ? [] : main_category.children_names
  end

  private

  def must_be_owned?
    return true if current_user.admin?
    if @classified.user != current_user
      redirect_to_back I18n.t("application.messages.insufficient_privilage")
      return false
    end
    return true
  end

  def index_for_admin_or_normal
    redirect_to(owned_classifieds_path) unless current_user.type == 'Admin'    
  end

end
