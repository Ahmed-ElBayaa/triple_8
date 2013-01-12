class AddCountryIdToCurrency < ActiveRecord::Migration
  def change
    add_column :currencies, :country_id, :integer
  end
end
