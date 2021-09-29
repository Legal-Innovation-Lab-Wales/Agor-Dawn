# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer

  def approved(user)
    mail(to: user.email, subject: 'Signup Approved',
         body: "#{user.full_name} your signup has been approved. You can now login here #{root_url}")
  end

  def rejected(user)
    mail(to: user.email, subject: 'Signup Rejected',
         body: "#{user.full_name} your signup request has been rejected. Please contact the team for further information")
  end
end
