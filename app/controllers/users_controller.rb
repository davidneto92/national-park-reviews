class UsersController < ApplicationController
  before_action :authorize_user
  before_action :authorize_edit, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @parks = @user.parks
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "Account details updated."
      redirect_to user_path(@user)
    else
      flash[:alert] = "Update failed"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :display_name
    )
  end

  def authorize_user
    if !user_signed_in?
      flash[:notice] = "Not authorized. Please sign in to view this user."
      redirect_to "/"
    end
  end

  def authorize_edit
    if current_user
      if current_user.id != params[:id].to_i
        render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      end
    end
  end

end
