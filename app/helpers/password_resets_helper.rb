module PasswordResetsHelper
  def extract_user_from_reset_params
    @user = User.find_by(email: params[:password_reset][:email].downcase)
  end

  def get_user_by_email
    @user = User.find_by(email: params[:email].downcase)
  end

  def valid_user
    unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
      redirect_to root_url, flash: {
        info: 'There is a problem with the reset url. Kindly request for a new one'
      }
    end
  end

  def check_reset_token_expiration
    msg = 'Password reset has expired.'
    if @user.reset_expired?
      redirect_to new_password_reset_url, flash: {alert: msg } 
    end
  end
end
