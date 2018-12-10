class AccountActivationsController < ApplicationController
  before_action :get_user, only: [:edit]
  def edit
    if @user && !@user.activated? && @user.authenticated?(:activation, params[:id])
      @user.activate!
      log_in @user
      redirect_to @user, flash: { success: 'Account activated!' }
    else
      redirect_to root_url, flash: { danger: 'Invalid activation link' }
    end
  end

  private

  def get_user
    @user = User.find_by(email: params[:email])
  end
end
