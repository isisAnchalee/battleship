class GamesController < ApplicationController
  before_action :ensure_players_belong_in_game, only: :show

  def new
    @game = Game.new
    render :new
  end

  def index
    @games = Game.order('created_at desc').page(params[:page]).per(10)
    render :index
  end

  # create game with placeholder player
  # until human player joins
  def create
    @game = Game.new(game_params)
    @game.first_player_id = current_user.id
    @game.second_player_id = Game::PLACEHOLDER_ID
    if @game.save!
      render :show
    else
      flash.now[:errors] = @game.errors.full_messages
      redirect_to root
    end
  end

  def update
    @game = Game.find(params[:id])
    @game.second_player_id = current_user.id 
    @game.state = 'setup'
    if @game.save!
      render :show
    else 
      render @game.errors.full_messages
    end
  end

  def show
    @game = Game.find(params[:id])
    render :show
  end

  private
  def game_params
    params.require(:game).permit(:room_name)
  end
end
