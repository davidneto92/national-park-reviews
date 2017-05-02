class UsersController < ApplicationController
  before_action :authorize_sign_in
  before_action :authorize_admin, only: [:index, :admin_edit, :admin_update]
  before_action :authorize_edit, only: [:edit, :update, :destroy]

  DEFAULT_AVATAR = "https://s3.amazonaws.com/national-park-reviews-development/uploads/avatars/default_avatar.jpg"

  def index
    @users = User.all.order(:id)
  end

  def show
    @user = User.find(params[:id])
    @parks = @user.parks
    @reviews = @user.reviews
    @default = DEFAULT_AVATAR
  end

  def edit
    @user = User.find(params[:id])
    @default = DEFAULT_AVATAR
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

  def admin_edit
    @user = User.find(params[:user_id])
  end

  def destroy
    binding.pry
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
