class CreateCategoriesClassifieds < ActiveRecord::Migration
  def change
    create_table :categories_classifieds, :id => false do |t|
    	t.references :category, :classified
    end
    add_index :categories_classifieds, [:category_id, :classified_id]
  end
end