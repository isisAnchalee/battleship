module Api
  module V1
    class BoardsController < Api::V1::ApiController 
      after_action :toggle_players, only: :update
      # before_action :validate_correct_player, only: :update
      skip_before_action :authenticate_user!, only: [:update]

      # Public: Main endpoint to send moves
      # 
      # http://localhost:3000/v1/games/1/boards/2
      def update
        @game = Game.find(params[:game_id])
        @board = Board.find(params[:id])
        response = play_move
        save_response(response)
        render json: { resp: response }
      end

      private

      def board_params
        params.require(:board).permit(:game_id, :user_id, :move)
      end

      def battleship_params
        { game_id: @game.id,
          user_id: @board.user_id,
          board: @board.board,
          game_state: @game.state }
      end

      def create_battleship_service
        Services::WombattleshipLogic.new(battleship_params)
      end

      def play_move
        create_battleship_service.make_move(params[:move])
      end

      def swap_turn
        toggle_players
        @game.save
      end

      def toggle_players
        if @game.current_user_id == @game.first_player_id
          @game.current_user_id = @game.second_player_id
        else
          @game.current_user_id = @game.first_player_id
        end
      end

      # Private - ensure current player plays on the opposite board
      def ensure_propper_players
        player_id = @game.current_user_id == @game.first_player_id ? @game.second_player_id : @game.first_player_id
        render json: { resp: 'it is not your turn' } unless player_id == @board.user_id
      end

      def save_response(response)
        @board.board = response[:board]
        @board.save
      end
    end
  end
end
