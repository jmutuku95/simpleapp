class SessionsController < ApplicationController
  before_action :get_user_from_session, only: [:create]
  def new; end

  def create
    if @user && @user.authenticate(params[:session][:password])
      handle_authenticated_user
    else
      flash.now[:danger] = 'Login failed! Ensure your credentials are right!'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def handle_authenticated_user
    if @user.activated?
      log_in(@user)
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or @user
    else
      redirect_to root_url, flash: { warning: "Account not activated. Check
        your email for the activation link." }
    end
  end

  def get_user_from_session
    @user = User.find_by(email: params[:session][:email].downcase)
  end
end
