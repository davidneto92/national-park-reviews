class AddWeatherUpdateToParks < ActiveRecord::Migration[5.0]
  def change
    add_column :parks, :nearby_city, :string
    add_column :parks, :last_weather_update, :timestamp
  end
end
