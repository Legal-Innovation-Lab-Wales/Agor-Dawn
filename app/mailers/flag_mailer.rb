# app/mailers/flags_mailer.rb
class FlagMailer < ApplicationMailer
  def new_flag(user, reason, type, project_id)
    @user = user
    @reason = reason
    @type = type
    @project_id = project_id

    mail(to: @user.email, subject: "Your #{type} has been flagged for review")
  end

  def user_resolved(admin, user, reason, type, project_id)
    @admin = admin
    @user = user
    @reason = reason
    @type = type
    @project_id = project_id

    mail(to: @admin.email, subject: 'A user has resolved a flag')
  end

  def admin_resolved(user, reason, type, project_id)
    @user = user
    @reason = reason
    @type = type
    @project_id = project_id

    mail(to: @user.email, subject: 'Your flag has been resolved')
  end
end
