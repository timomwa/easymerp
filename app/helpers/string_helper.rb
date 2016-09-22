module StringHelper
  def shortenStr(original_str, max_size)
    new_str = original_str
    if(!new_str.nil? && new_str.length > max_size)
      #max_size = (new_str.length-3) >= 0 ? (new_str.length-3) :   new_str.length
      new_str = original_str[0...(max_size)] + "..."
    end
    new_str
  end
end