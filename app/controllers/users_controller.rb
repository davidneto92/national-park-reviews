class UsersController < ApplicationController
  before_action :authorize_sign_in
  before_action :authorize_admin, only: [:index]
  before_action :authorize_edit, only: [:edit, :update, :destroy]

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
      flash[:alert] = "That image is too large. Avatars must be smaller than 500kb."
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :display_name,
      :avatar,
      :remove_avatar
    )
  end

  def authorize_sign_in
    if !user_signed_in?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

  def authorize_admin
    if !current_user.admin?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

  def authorize_edit
    if !current_user.admin? && current_user.id != params[:id].to_i
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

end
