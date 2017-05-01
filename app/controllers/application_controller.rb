class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def recent_data
    # gathers 4 most recently created parks
    @recent_parks = Park.all.order(created_at: :DESC)[0..3]

    # gathers 4 most recently written reviews
    @recent_reviews = Review.all.order(created_at: :DESC)[0..3]
  end
end
