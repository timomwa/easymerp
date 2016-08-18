class ApplicationMailer < ActionMailer::Base
  include Resque::Mailer
  default from: "hondaownersclub@technovation.co.ke"
  layout 'mailer'
end