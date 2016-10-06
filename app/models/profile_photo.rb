class ProfilePhoto < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  belongs_to :member_profile
end