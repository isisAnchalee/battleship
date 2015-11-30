class GamesController < ApplicationController
  before_action :query_scoped_games, only: [:new, :index]
  after_action :setup_boards, only: :update

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
    if @game.save
      render :show
    else
      flash[:errors] = @game.errors.full_messages.join("")
      redirect_to root_path
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

  # games where first_player_id or second_player_id == current_user.id
  def query_scoped_games
    @open_games = Game.open_games(current_user.id, current_user.id)
  end
  
  def setup_boards
    @game.player_ids.each do |player_id|
      Services::BoardFactory.new({ game_id: @game.id,
                                   user_id: player_id }).build_board
    end
  end
end
