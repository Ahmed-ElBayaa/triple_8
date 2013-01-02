class ChangePriceOfClassified < ActiveRecord::Migration
  def up
  	change_column :classifieds, :price, :decimal, precision: 8, scale: 2
  end

  def down
  	change_column :classifieds, :price, :decimal
  end
end
