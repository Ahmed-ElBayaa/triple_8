class RemoveAncestryFromCategory < ActiveRecord::Migration
  def change
  	remove_column :categories, :ancestry
  end
end
