class AddIdentifierToClassified < ActiveRecord::Migration
  def change
    add_column :classifieds, :identifier, :string
  end
end
