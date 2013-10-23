module ApplicationHelper

  def full_title(page_title)
    base_title = "Ads"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def flash_class(type)
    case type
      when :notice then "alert alert-info"
      when :alert then "alert alert-error"
      when :error then "alert alert-erro"
      when :success then "alert alert-success"
    end
  end
end
