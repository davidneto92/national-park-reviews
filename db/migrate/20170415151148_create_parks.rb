class CreateParks < ActiveRecord::Migration[5.0]
  def change
    create_table :parks do |t|
      t.string :name, null: false
      t.string :main_image, null: false # stores url path to image
      t.string :state, null: false
      t.integer :year_founded
      t.integer :area_miles

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
