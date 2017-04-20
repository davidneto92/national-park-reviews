class ParksController < ApplicationController
  # before_action :authorize_user, except: [:index, :show]
  # before_action :authorize_edit

  def index
    @parks = Park.all
  end

  def show
    @park = Park.find(params[:id])
    @state = Park::STATES.find { |state| state.include?(@park.state) }
    if @park.user.display_name.nil?
      @creator_name = @park.user.email
    else
      @creator_name = @park.user.display_name
    end
  end

  def new
    @park = Park.new
    @state_collection = Park::STATES
  end

  def edit
    @park = Park.find(params[:id])
    @state_collection = Park::STATES
  end

  def create
    @park = Park.new(new_park_params)
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

    if @park.update(new_park_params)
      flash[:notice] = "#{@park.name} updated."
      redirect_to park_path(@park)
    else
      flash[:alert] = "Update failed"
      @state_collection = Park::STATES
      render :edit
    end
  end

  private

  def new_park_params
    params.require(:park).permit(
      :name,
      :main_image,
      :state,
      :year_founded,
      :area_miles
    )
  end

  # def authorize_user
  #   # binding.pry
  #   if !user_signed_in? || !current_user.admin?
  #     raise ActionController::RoutingError.new("Not Found")
  #   end
  # end

  def authorize_login

  end

end
