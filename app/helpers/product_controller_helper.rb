module ProductControllerHelper
  def getProductDefaultAvatar(product)

    avatar = nil

    if(!product.images.nil? && product.images.size>0)

      avatar  =  product.images[0].avatar

      product.images.each do |image|
        if(image.defaultimg==true)
          avatar = image.avatar
          break
        end
      end

    end

    avatar

  end

=begin
  TODO Search product pricing that falls within
  the current date.
=end

  def getActivePricing(product)

    pricing = nil

    if(!product.product_pricings.nil?)
      product.product_pricings.each do |pp|
        pricing = pp
        break
      end
    end
    pricing
  end

  def findActiveProductPricing(product_id)
    ProductPricing.findActivePricing(product_id)
  end
  
  
  def findActiveProductDiscount(product_id, discount_type)
    ProductDiscount.findActiveDiscounts(product_id,discount_type);
  end

end
