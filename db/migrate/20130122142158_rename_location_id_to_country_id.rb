class RenameLocationIdToCountryId < ActiveRecord::Migration
  def change
		rename_column :classifieds, :location_id, :country_id
	end
end
