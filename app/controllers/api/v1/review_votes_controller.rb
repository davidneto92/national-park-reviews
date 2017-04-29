class Api::V1::ReviewVotesController < ApplicationController
  before_action :authorize_sign_in

  def create
    @review = Review.find(params[:review_id])
    @vote = ReviewVote.where(review_id: @review.id, user_id: current_user.id)[0]

    ReviewVote.create(choice: params[:choice], review_id: @review.id, user_id: current_user.id, park_id: params[:park_id])
    redirect_to park_path(@review.park)
  end

  def update
    @change = ReviewVote.find(params[:id])
    @change.choice = params[:choice]
    @change.save
  end

  def index
    render json: ReviewVote.all
  end

  def authorize_sign_in
    if !user_signed_in?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

end
