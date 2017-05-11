require 'rest-client'

class WeatherFetcherJob
  attr_reader :park

  def initialize(park)
    @park = park
  end

  def perform
    # Get the weather for location
    url = "http://api.wunderground.com/api/#{ENV['WUNDERGROUND_KEY']}/forecast/q/#{park.state_abbreviation}/#{park.nearby_city}.json"
    response = RestClient.get(url)

    # Turn the body into a hash
    body = JSON.parse(response)

    ParkWeather.create(
      forecast_day_0: body["forecast"]["simpleforecast"]["forecastday"][0],
      forecast_day_1: body["forecast"]["simpleforecast"]["forecastday"][1],
      forecast_day_2: body["forecast"]["simpleforecast"]["forecastday"][2],
      forecast_day_3: body["forecast"]["simpleforecast"]["forecastday"][3]
    )

    park.last_weather_update = Time.now
    park.save
  end
end

# use WeatherFetcherJob.new(Park.first).delay.perform
