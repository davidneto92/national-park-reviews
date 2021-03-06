class ParksController < ApplicationController
  before_action :authorize_sign_in, only: [:upvote, :downvote]
  before_action :authorize_edit, only: [:edit, :update, :destroy]

  def index
    if params[:search_terms]
      ActiveRecord::Base.connection.execute("SELECT set_limit(0.15);")
      @parks = Park.fuzzy_search(params[:search_terms]).page params[:page]
      if Park.fuzzy_search(params[:search_terms]).empty?
        flash.now[:notice] = "No results found for #{params[:search_terms]}."
      end
    else
      @parks = Park.order("name").page params[:page]
    end
    recent_data
  end

  def show
    @park = Park.find(params[:id])
    @creator_name = @park.user.display_name
    @reviews = Review.where(park_id: params[:id]).order('created_at DESC')
    @review_id_list = @reviews.map { |review| review.id }
    recent_data # for displaying on side bar

    # this will display the forecast div if the weather has been updated
    if !@park.park_forecasts.empty?
      @display_weather = true
      @forecast = @park.park_forecasts.last
      @simple_forecast = @forecast.simple_forecasts
    else
      @display_weather = false
    end

  end

  def new
    @park = Park.new
    @state_collection = Park::STATES
    recent_data
  end

  def edit
    @park = Park.find(params[:id])
    @state_collection = Park::STATES
    recent_data
  end

  def create
    @park = Park.new(park_params)
    @park.user_id = current_user.id

    if @park.save
      flash[:notice] = "#{@park.name} created!"
      redirect_to park_path(@park)
    else
      flash[:alert] = "New park not created"
      @state_collection = Park::STATES
      render :new
    end
  end

  def update
    @park = Park.find(params[:id])

    if @park.update(park_params)
      flash[:notice] = "#{@park.name} updated."
      redirect_to park_path(@park)
    else
      flash[:alert] = "Update failed"
      @state_collection = Park::STATES
      render :edit
    end
  end

  def destroy
    @park = Park.find(params[:id])
    @park.destroy
    redirect_to parks_path
  end

  def upvote
    @park = Park.find(params[:park_id])
    @vote = ParkVote.where(park_id: params[:park_id], user_id: current_user.id)[0]

    if @vote.nil?
      ParkVote.create(choice: 1, park_id: @park.id, user_id: current_user.id)
      redirect_to park_path(@park)
    elsif @vote.choice == 1
      @vote.choice = 0
      @vote.save
      redirect_to park_path(@park)
    else
      @vote.choice = 1
      @vote.save
      redirect_to park_path(@park)
    end
  end

  def downvote
    @park = Park.find(params[:park_id])
    @vote = ParkVote.where(park_id: params[:park_id], user_id: current_user.id)[0]

    if @vote.nil?
      ParkVote.create(choice: -1, park_id: @park.id, user_id: current_user.id)
      redirect_to park_path(@park)
    elsif @vote.choice == -1
      @vote.choice = 0
      @vote.save
      redirect_to park_path(@park)
    else
      @vote.choice = -1
      @vote.save
      redirect_to park_path(@park)
    end
  end

  private

  def park_params
    params.require(:park).permit(:name, :main_image, :state, :year_founded, :area_miles)
  end

  def authorize_sign_in
    if !user_signed_in?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

  def authorize_edit
    if current_user
      if current_user.id != Park.find(params[:id]).user_id && !current_user.admin?
        render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      end
    else
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

end
