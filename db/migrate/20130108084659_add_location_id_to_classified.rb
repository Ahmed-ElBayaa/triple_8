class AddLocationIdToClassified < ActiveRecord::Migration
  def change
    add_column :classifieds, :location_id, :integer
  end
end
