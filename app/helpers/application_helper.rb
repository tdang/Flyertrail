module ApplicationHelper
  
  # Return a title on a per-page basis.
  def title
    base_title = "Flyertrail"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    image_tag("logo.jpeg", :alt => "FlyerTrail", :class => "logo")
  end
  
  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end
end