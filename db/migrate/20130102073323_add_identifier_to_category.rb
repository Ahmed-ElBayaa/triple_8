class AddIdentifierToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :identifier, :string
    add_index :categories, :identifier
  end
end
