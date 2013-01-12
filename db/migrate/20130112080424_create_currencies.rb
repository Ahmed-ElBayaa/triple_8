class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :unit
      t.float :ratio

      t.timestamps
    end
  end
end
