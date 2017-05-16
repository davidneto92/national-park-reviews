class CreateParkForecasts < ActiveRecord::Migration[5.0]
  def change
    create_table :park_forecasts do |t|
      t.jsonb :forecast_day_0
      t.jsonb :forecast_day_1
      t.jsonb :forecast_day_2
      t.jsonb :forecast_day_3

      t.timestamps

      t.references :park, foreign_key: true
    end
  end
end
