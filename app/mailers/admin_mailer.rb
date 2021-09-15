# app/mailers/admin_mailer.rb
class AdminMailer < ApplicationMailer

  def new_user_signup(user, admin)
    @admin = admin
    @user = user
    mail(to: @admin.email, subject: 'New User Signup', body: 'A new user has signed up, sign in to approve them')
  end
end
