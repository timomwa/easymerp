class ActivationInstructionsMailer < ApplicationMailer
  def activation_instructions(user)
    @user = user
    mail(to: @user.email, subject: 'Easy M-erp : Activation Instructions')
  end

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Easy M-erp :  Welcome to the site!')
  end

end