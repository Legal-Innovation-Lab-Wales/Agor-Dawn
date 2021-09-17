# app/mailers/flags_mailer.rb
class FlagsMailer < ApplicationMailer
  def new_flag_email(flag)
    @flag = flag
    @flag_type = flag.flaggable_type.downcase
    @project_id = case flag.flaggable
                  when Project
                    flag.id
                  when Comment
                    flag.project_id
                  end
    mail(to: 'garethdandrews@gmail.com', subject: "Your #{@flag_type} has been flagged for review")
  end

  def updated_flag_email

  end
end
