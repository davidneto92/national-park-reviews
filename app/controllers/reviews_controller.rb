class ReviewsController < ApplicationController
  before_action :authorize_sign_in
  before_action :authorize_edit, only: [:edit, :update, :destroy]
  respond_to :html, :js

  def new
    @park = Park.find(params[:park_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.park_id = params[:park_id]
    @park = Park.find(params[:park_id])

    if @review.save
      flash[:notice] = "Review created!"
      redirect_to park_path(@park)
    else
      flash[:alert] = "New review not created"
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
    @park = Park.find(params[:park_id])
  end

  def update
    @park = Park.find(params[:park_id])
    @review = Review.find(params[:id])
    @review.update(review_params)
    if @review.save
      flash[:notice] = "Review successfully updated."
      redirect_to park_path(@park)
    else
      flash[:alert] = "Review update failed."
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @park = Park.find(params[:park_id])
    @review.destroy
    redirect_to park_path(@park)
  end

  def upvote
    @review = Review.find(params[:review_id])
    @vote = ReviewVote.where(review_id: @review.id, user_id: current_user.id)[0]

    if @vote.nil?
      ReviewVote.create(choice: 1, review_id: @review.id, user_id: current_user.id, park_id: @review.park.id)
      redirect_to park_path(@review.park)
    elsif @vote.choice == 1
      @vote.choice = 0
      @vote.save
      redirect_to park_path(@review.park)
    else
      @vote.choice = 1
      @vote.save
      redirect_to park_path(@review.park)
    end
  end

  def downvote    
    @review = Review.find(params[:review_id])
    @vote = ReviewVote.where(review_id: @review.id, user_id: current_user.id)[0]

    if @vote.nil?
      ReviewVote.create(choice: -1, review_id: @review.id, user_id: current_user.id, park_id: @review.park.id)
      redirect_to park_path(@review.park)
    elsif @vote.choice == -1
      @vote.choice = 0
      @vote.save
      redirect_to park_path(@review.park)
    else
      @vote.choice = -1
      @vote.save
      redirect_to park_path(@review.park)
    end
  end

  private

  def review_params
    params.require(:review).permit(
      :title,
      :body,
      :visit_date
    )
  end

  def authorize_sign_in
    if !user_signed_in?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

  def authorize_edit
    review_to_edit = Review.where(id: params[:id])[0]
    if !current_user.admin? && !current_user.reviews.include?(review_to_edit)
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

end
