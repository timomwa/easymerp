class AccountingPeriod < ActiveRecord::Base
  has_many :general_ledgers
  validates_uniqueness_of :fromDate
  validates_uniqueness_of :toDate
  enum status: { open: 0, closed: 1, Select: -1 }
  validate :validate_status
    
  def validate_status
    if(self.status.nil? || self.status == "Select")
      errors.add(:status, "Please select whether the period is closed or open")
    end
  end
end