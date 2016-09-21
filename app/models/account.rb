class Account < ActiveRecord::Base
  has_many :account_balances
  has_many :general_ledgers
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
end