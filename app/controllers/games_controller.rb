class GamesController < ApplicationController
  after_filter :build_game_board, only: :create

  def new
    @game = Game.new
    render :new
  end

  def index
    @games = Game.order('created_at desc').page(params[:page]).per(10)
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
    params.require(:game).permit(:room_name)
  end

  def build_game_board
    @board = Board.new({ player_id: current_user.id,
                         game_id: @game.id })
    if @board.save!
      flash[:notice] = 'success!!!!'
    else
      flash.now[:errors] = @board.errors.full_messages
    end
  end
end
