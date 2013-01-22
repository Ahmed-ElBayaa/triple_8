class AddColumnsToClassified < ActiveRecord::Migration
  def change
    add_column :classifieds, :latitude, :float
    add_column :classifieds, :longitude, :float
  end
end
