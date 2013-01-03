class AddMainCategoryAndSubCategoryToClassifieds < ActiveRecord::Migration
  def change
    add_column :classifieds, :main_category_id, :integer
    add_column :classifieds, :sub_category_id, :integer
  end
end
