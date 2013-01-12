class CurrenciesController < ApplicationController
  
  def index
    @currencies = Currency.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def edit
    @currencies = Currency.all
    @currencies << Currency.new
    @currencies << Currency.new
  end

  def update

  	success = true
  	params.each do |k,v|
  	  id = k.to_i
  	  if id > 0
  	  	currency = Currency.find(id)
  	  	success &&= currency.update_attributes(v)
  	  elsif id < 0
  	  	currency = Currency.new(v)
  	  	success &&= currency.save
  	  end
  	end	
    respond_to do |format|
      if success
        format.html { redirect_to currencies_path, 
          notice: I18n.t('application.messages.successfully_updated', model: 'currency') }
        format.json { head :ok }
      else
      	@currencies = Currency.all
    	@currencies << Currency.new
    	@currencies << Currency.new
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
