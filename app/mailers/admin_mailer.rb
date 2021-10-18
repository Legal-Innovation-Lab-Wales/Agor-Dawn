# app/mailers/admin_mailer.rb
class AdminMailer < ApplicationMailer
  def new_user_signup(user, admin)
    @recipient = admin
    @user = user

    mail(to: @recipient.email, subject: 'New User Signup')
  end

  def approved(user)
    @recipient = user

    mail(to: recipient.email, subject: 'Sign-up Approved')
  end

  def rejected(user)
    @recipient = user

    mail(to: recipient.email, subject: 'Sign-up Rejected')
  end
end
