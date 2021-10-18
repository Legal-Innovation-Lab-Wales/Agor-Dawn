# app/mailers/bugs_mailer.rb
class BugsMailer < ApplicationMailer
  def new_bug(admin, user, summary, description)
    @recipient = admin
    @user = user
    @summary = summary
    @description = description

    mail(to: @recipient.email, subject: 'New Bug Reported')
  end
end
