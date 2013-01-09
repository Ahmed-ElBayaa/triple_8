class AddPhoneToClassified < ActiveRecord::Migration
  def change
    add_column :classifieds, :phone, :string
  end
end
