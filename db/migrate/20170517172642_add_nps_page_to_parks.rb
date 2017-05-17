class AddNpsPageToParks < ActiveRecord::Migration[5.0]
  def change
    add_column :parks, :nps_page, :string
    add_column :parks, :nps_description, :text
  end
end
