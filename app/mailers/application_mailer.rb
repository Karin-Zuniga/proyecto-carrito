class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.correo[:correo]
  layout 'mailer'
end
