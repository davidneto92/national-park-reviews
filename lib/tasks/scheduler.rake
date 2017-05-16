desc "This task is called by the Heroku scheduler add-on to update the forecast for Arches"
# ditching snakecase to see if that will work with heroku scheduler
task :updateForecast => :environment do
  park = Park.where(name: "Arches National Park").first
  ForecastFetcherJob.new(park).perform
end
