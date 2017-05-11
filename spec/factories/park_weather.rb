# not sure if this is correct...to hard code everthing...

url = "http://api.wunderground.com/api/8c45b1973db20c1d/forecast/q/UT/Moab.json"
sample_json = JSON.parse(RestClient.get(url))

FactoryGirl.define do
  factory :park_weather do
    forecast_day_0 sample_json["forecast"]["simpleforecast"]["forecastday"][0]
    forecast_day_1 sample_json["forecast"]["simpleforecast"]["forecastday"][1]
    forecast_day_2 sample_json["forecast"]["simpleforecast"]["forecastday"][2]
    forecast_day_3 sample_json["forecast"]["simpleforecast"]["forecastday"][3]
  end
end
