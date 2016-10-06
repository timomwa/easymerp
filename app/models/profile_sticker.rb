class ProfileSticker < ActiveRecord::Base
  belongs_to :member_profile
  enum sticker_status: { REQUESTED: 0, REQUESTED_FOR_REPRINT: 1, WAITING_FOR_PICKUP: 2, ISSUED: 3, IN_CONTENTION: 4, REVOKED: 5}

end