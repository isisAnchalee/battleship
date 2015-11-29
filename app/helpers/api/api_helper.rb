module Api::ApiHelper

  def ensure_players_belong_in_game
    @game.player_ids.include?(params[:user_id])
  end
end
