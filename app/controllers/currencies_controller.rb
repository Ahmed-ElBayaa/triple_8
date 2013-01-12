class CurrenciesController < ApplicationController
  before_filter :must_be_admin
  def index
    @currencies = Currency.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def edit
    @currencies = Currency.all
    @countries = Country.select([:id, :name])
    @countries_array = "[[]"
    @countries.each do |country|
      @countries_array << ",['#{country.id}', '#{country.name}']"
    end
    @countries_array <<"]"

  end

  def update

  	success = true
  	params[:currency].each do |k,v|
  	  id = k.to_i
	  	currency = Currency.find(id)
	  	success &&= currency.update_attributes(v)
	  end
    params[:new] ||= []
    params[:new].each do |k,v|
	  	currency = Currency.new(v)
	  	success &&= currency.save
  	end	
    respond_to do |format|
      if success
        format.html { redirect_to currencies_path, 
          notice: I18n.t('application.messages.successfully_updated', model: 'currency') }
        format.json { head :ok }
      else
      	@currencies = Currency.all
        @countries = Country.select([:id, :name])
        @countries_array = "[[]"
        @countries.each do |country|
          @countries_array << ",['#{country.id}', '#{country.name}']"
        end
        @countries_array <<"]"
        format.html { render action: "edit" }
        format.json { render json: @currencies.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @currency = Currency.find(params[:id])
    @currency.destroy

    respond_to do |format|
      format.html { redirect_to currencies_url }
      format.json { head :ok }
    end
  end

end
