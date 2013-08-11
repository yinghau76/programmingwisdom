module ApplicationHelper
  def icon(name)
    content_tag(:i, nil, class: "icon-#{name}")
  end
end
