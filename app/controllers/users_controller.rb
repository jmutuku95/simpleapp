class UsersController < ApplicationController
  before_action :get_user, only: %i[edit update show destroy]
  before_action :logged_in_user, only: %i[index edit update]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end
  def show
    @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to @user, success:"User details successfully updated."
    else
      render 'edit', error: "Update failed"
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: "User has been deleted"
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end

  def get_user
    @user = User.find(params[:id])
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in first."
      redirect_to login_url
    end
  end

  def correct_user
    redirect_to current_user unless current_user?(@user)
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
