class ParkForecast < ApplicationRecord
  belongs_to :park

  def simple_forecasts
    list = []
    [self.forecast_day_0, self.forecast_day_1, self.forecast_day_2, self.forecast_day_3].each do |day|
      list << {
        date: "#{day["date"]["weekday"]}, #{day["date"]["month"]}/#{day["date"]["day"]}",
        high: "#{day["high"]["fahrenheit"]}",
        low: "#{day["low"]["fahrenheit"]}"
      }
    end

    return list
  end

end
