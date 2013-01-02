class CreateClassifieds < ActiveRecord::Migration
  def change
    create_table :classifieds do |t|
      t.string :kind
      t.string :title
      t.text :description
      t.decimal :price
      t.integer :user_id

      t.timestamps
    end
  end
end
