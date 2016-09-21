=begin
This is a general ledger entity for recording
all account entries (Debit and credit)
=end
class GeneralLedger < ActiveRecord::Base
  belongs_to :account
  belongs_to :accounting_period
end