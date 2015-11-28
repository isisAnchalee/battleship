class GamesController < ApplicationController
  def new
    @game = Game.new
    render :new
  end

  def index
    @games = Game.order('created_at desc').page(params[:page]).per(2)
    render :index
  end

  def create
    @game = Game.new(game_params)
    @game.first_player_id = current_user.id

    if @game.save!
      render :show
    else
      flash.now[:errors] = @game.errors.full_messages
      redirect_to root
    end
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
