class ApplicationMailer < ActionMailer::Base
  include Resque::Mailer
  default from: "noreply@easymerp.com"
  layout 'mailer'
end