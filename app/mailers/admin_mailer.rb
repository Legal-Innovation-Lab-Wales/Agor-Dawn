# app/mailers/admin_mailer.rb
class AdminMailer < ApplicationMailer
  def new_user_signup(user, admin)
    @admin = admin
    @user = user

    mail(to: @admin.email, subject: 'New User Signup')
  end

  def approved(user)
    @user = user

    mail(to: user.email, subject: 'Sign-up Approved')
  end

  def rejected(user)
    @user = user

    mail(to: user.email, subject: 'Sign-up Rejected')
  end
end
