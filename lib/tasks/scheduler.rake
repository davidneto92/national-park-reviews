desc "This task is called by the Heroku scheduler add-on to update the forecast for Arches"
task :update_arches_forecast => :environment do
  park = Park.where(name: "Arches National Park").first
  ForecastFetcherJob.new(park).perform
end
