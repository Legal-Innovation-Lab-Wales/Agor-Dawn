class ApplicationMailer < ActionMailer::Base
  default from: 'agor-dawn-demo@legaltech.wales'

  layout 'mailer.html.erb'
end
