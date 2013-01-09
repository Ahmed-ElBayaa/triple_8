class AddTagsToClassified < ActiveRecord::Migration
  def change
    add_column :classifieds, :tags, :string
  end
end
