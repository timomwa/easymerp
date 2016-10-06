class ProfileCar < ActiveRecord::Base
  belongs_to :member_profile
  has_many :profile_car_photos
end