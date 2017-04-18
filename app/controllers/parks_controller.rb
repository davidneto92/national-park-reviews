class ParksController < ApplicationController
  def index
    @parks = Park.all
  end

  def show
    @park = Park.find(params[:id])
    @state = Park::STATES.find { |state| state.include?(@park.state) }
  end

  def new
    @park = Park.new
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

  private

  def new_park_params
    params.require(:park).permit(
      :name,
      :main_image,
      :state,
      # :user_id
    )
  end
end
