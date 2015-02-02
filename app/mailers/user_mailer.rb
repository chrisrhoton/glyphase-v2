class UserMailer < ApplicationMailer

  default from: "noreply@glyphbase.com"

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Glyphbase - Account activation"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Glyphbase - Password reset"
  end
end
