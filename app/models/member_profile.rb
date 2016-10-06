class MemberProfile < ActiveRecord::Base
  belongs_to :user
  has_many :profile_contacts
  has_many :profile_cars
  has_many :profile_stickers
  
  def self.findByUserId(user_id)
    where("user_id = ?  ", user_id ).first
  end
end