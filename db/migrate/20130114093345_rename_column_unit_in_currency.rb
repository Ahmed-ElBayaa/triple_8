
class RenameColumnUnitInCurrency < ActiveRecord::Migration
	def change
		rename_column :currencies, :unit, :name
	end
end
