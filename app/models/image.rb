class Image < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  belongs_to :product
  belongs_to :inventory
  
  def self.findDefaultImage(product_id)
    psttmt = where("product_id = ? and defaultimg = 1 ", product_id)
  end
end