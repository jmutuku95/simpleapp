class UsersController < ApplicationController
  include UsersHelper
  before_action :get_user, only: %i[edit update show destroy]
  before_action :logged_in_user, only: %i[index edit update]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.active.paginate(page: params[:page])
  end

  def show
    redirect_to(root_url) && return unless @user.activated?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, flash: { info: 'Please check your email to activate
        your account.' }
    else
      render 'new', flash: { info: 'User creation was not successful' }
    end
  end

  def edit
    @user
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to @user, flash: { success: 'User details successfully updated.' }
    else
      render 'edit', flash: { error: 'Update failed' }
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, flash: { info: 'User has been deleted' }
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
end
