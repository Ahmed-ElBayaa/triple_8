class AddUnitIdToClassified < ActiveRecord::Migration
  def change
    add_column :classifieds, :unit_id, :integer
  end
end
