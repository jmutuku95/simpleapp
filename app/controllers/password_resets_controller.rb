class PasswordResetsController < ApplicationController
  include PasswordResetsHelper
  before_action :extract_user_from_reset_params, only: %i[create]
  before_action :get_user_by_email, only: %i[edit update]
  before_action :valid_user, only: %i[edit update]
  before_action :check_reset_token_expiration, only: %i[edit update]
  
  def new; end

  def create
    if @user
      @user.create_reset_digest!
      redirect_to root_url, flash: {
        info: 'Check your email for password reset instructions.'
      }
    else
      redirect_to new_password_reset_path, flash: {
        info: 'Email address not found'
      }
    end
  end

  def edit
  end

  def update
    # binding.pry
    if @user.update_attributes(reset_params)
      log_in @user
      redirect_to @user, flash: { success: 'Password has been reset.' }
    else
      render 'edit'
    end
  end

  private

  def reset_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
