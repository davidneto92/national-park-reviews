require 'rest-client'

class WeatherFetcherJob
  attr_reader :location

  def initialize(location)
    @location = location
  end

  def perform
    # Get the wether for location
    url = "http://api.wunderground.com/api/#{ENV['WUNDERGROUND_KEY']}/conditions/aq/?query=#{URI.encode(location)}.json"

    response = RestClient.get(url)

    puts JSON.parse(response)
    puts "HELLO FROM #{location}"
  end
end
