module ApplicationHelper

  def fa_icon_tag(icon_name, classes = nil)
    content_tag(:i, nil, :class => "fa fa-#{icon_name} #{classes}")
  end
end
