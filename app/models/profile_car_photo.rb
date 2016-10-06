class ProfileCarPhoto < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  belongs_to :profile_car
end