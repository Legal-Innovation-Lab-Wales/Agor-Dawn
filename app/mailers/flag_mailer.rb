# app/mailers/flags_mailer.rb
class FlagMailer < ApplicationMailer
  def new_flag(user, reason, type, project_id)
    @user = user
    @reason = reason
    @type = type
    @project_id = project_id

    mail(to: @user.email, subject: "Your #{type} has been flagged for review!")
  end

  def update_flag; end
end
