module ApplicationHelper
  def ensure_players_belong_in_game
    @game.player_ids.include?(params[:user_id])
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def build_blinking_header
    str, result = 'Wombattleships', ''
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

  private
  def render_unauthorized
  end
end
