module PasswordResetsHelper
  def find_user_from_reset_token
    @user = User.find_by(email: params[:password_reset][:email].downcase)
  end

  def locate_user_by_email
    @user = User.find_by(email: params[:email].downcase)
  end

  def valid_user
    unless user_is_valid?
      redirect_to root_url, flash: {
        info: 'There is a problem with the reset url. Kindly request for a new one'
      }
    end
  end

  def check_reset_token_expiration
    msg = 'Password reset has expired.'
    if @user.password_reset_token_expired?
      redirect_to new_password_reset_url, flash: { alert: msg }
    end
  end

  def user_is_valid?
    @user && @user.activated? && @user.authenticated?(:reset, params[:id])
  end
end
