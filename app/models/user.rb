class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    PasswordResetMailer.reset_email(self).deliver
  end

  def activate!
    self.active = true
    save
  end

  def disapprove
    self.approved = false
    save
  end

  def approve
    self.approved = true
    save
  end

  def deliver_activation_instructions!
    reset_perishable_token!
    ActivationInstructionsMailer.activation_instructions(self).deliver
  end

  def deliver_welcome!
    reset_perishable_token!
    self.approved = true
    self.confirmed = true
    save
    ActivationInstructionsMailer.welcome(self).deliver
  end

  def role_symbols
    (roles || []).map {|r| r.title.to_sym}
  end

end
