class GamesController < ApplicationController
  def new
    @game = Game.new
    render :new
  end

  def show
    @game = Game.find(params[:id])
    render :show
  end

  private
  def game_params
    params.require(:game)
      .permit(:first_player_id, :room_name)
  end
end
