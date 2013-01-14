class ChangeColumnUnitIdName < ActiveRecord::Migration
  def change
		rename_column :classifieds, :unit_id, :currency_id
	end
end
