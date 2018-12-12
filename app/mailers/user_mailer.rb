class UserMailer < ApplicationMailer
  def account_activation(user, activation_token)
    binding.pry
    @user = user
    @token = activation_token
    mail to: user.email, subject: 'Account Activation'
  end

  def password_reset(user, password_reset_token)
    binding.pry
    @user = user
    @token = password_reset_token
    mail to: @user.email, subject: 'Reset Password'
  end
end
