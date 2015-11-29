module Api
  module V1
    class BoardsController < Api::V1::ApiController 
      before_action :ensure_players_belong_in_game, only: :update

      # main endpoint to send moves
      def update
        @game = Game.find(params[:game_id])
        @board = @game.boards.find(params[:id])
        response = make_move
        render json: { resp: @service }
      end

      private

      def board_params
        params.require(:board).permit(:game_id, :user_id, :move, :player)
      end

      def create_battleship_service
        Services::BoardFactory.new(battleship_params)
      end
      
      def make_move
        create_battleship_service.make_move(params[:move])
      end

      def battleship_params
        { game_id: @game.id,
          player_id: params[:user_id],
          board: @board.board,
          game_state: @game.state }
      end
    end
  end
end
