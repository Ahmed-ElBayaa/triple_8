class AddEmailToClassified < ActiveRecord::Migration
  def change
    add_column :classifieds, :email, :string
  end
end
