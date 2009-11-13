# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  
  # returns a yes/no image small size
  def boolean_to_image_lock(bol)
    if bol && (bol == true)
      return image_tag("/images/lock22.png", :class => "align-center")
    else
      return nil
    end
  end
  
  # returns a yes/no image small size
  def boolean_to_image_small(bol)
    if bol
      return image_tag("/images/yes_small.png", :class => "align-center")
    else
      return image_tag("/images/no_small.png", :class => "align-center")
    end
  end
  
  # returns a proper image bigger
  def boolean_to_image_big(bol)
    if bol
      return image_tag("/images/yes.png", :class => "align-center")
    else
      return image_tag("/images/no.png", :class => "align-center")
    end
  end

  # returns a proper image 
  def boolean_to_word(bol)
    if bol 
      return "Yes"
    else
      return "No"
    end
  end
  # returns a proper image 
  def boolean_to_word_yes(bol)
    if bol 
      return "Yes"
    else
      return ""
    end
  end
  # returns a proper image 
  def boolean_to_word_no(bol)
    if bol 
      return ""
    else
      return "No"
    end
  end
  
  
end
