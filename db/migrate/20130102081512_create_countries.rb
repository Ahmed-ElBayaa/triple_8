class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :short_name
      t.string :identifier

      t.timestamps
    end
  end
end