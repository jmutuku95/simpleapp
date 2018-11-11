class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account Activation"
  end

  def password_reset
    @greeting = "Hi"
    mail to: "to@example.org", subject: "Reset Password"
  end
end