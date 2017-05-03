require 'rest-client'

class WeatherFetcherJob
  attr_reader :location, :state_code

  def initialize()
    @location = 'San Fransico'
    @state_code = 'CA'
  end

  def perform
    # Get the wether for location
    url = "http://api.wunderground.com/api/#{ENV['WUNDERGROUND_KEY']}/forecast/q/#{state_code}/#{URI.encode(location)}.json"
    response = RestClient.get(url)

    # Turn the body into a hash
    body = JSON.parse(response)

    # Maybe we update the park model with a forecast for the day and a forcast_updated_at timestamp to tell how out of date out forecast is

  end
end
