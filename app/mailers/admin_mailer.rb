# app/mailers/admin_mailer.rb
class AdminMailer < ApplicationMailer

  def new_user_signup(user, admin)
    @admin = admin
    @user = user
    mail(to: @admin.email, subject: 'New User Signup', body: "A new user, #{user.full_name} has signed up with the email address #{user.email}. Sign in to approve them #{admin_index_url}")
  end
end
