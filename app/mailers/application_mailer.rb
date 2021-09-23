class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.envio_mail[:correo]
  layout 'mailer'
end
