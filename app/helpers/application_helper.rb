module ApplicationHelper

  def build_blinking_header
    str, result, alternate = 'Wombattleships', ''
    alternate = false
    str.chars.each_with_index do |char, i|
      prefix = ''
      if i % 2 == 0
        alternate ^= true
        prefix = alternate ? "<span class='blink-blue-header'>" : "<span class='blink-red-header'>"
      end
      result += prefix + char
      result += '</span>' unless prefix == ''
    end
    result
  end

  def fa_icon_tag(icon_name, classes = nil)
    content_tag(:i, nil, :class => "fa fa-#{icon_name} #{classes}")
  end
end
