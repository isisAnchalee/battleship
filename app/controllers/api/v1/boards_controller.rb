module Api
  module V1
    class BoardsController < Api::V1::ApiController 

      def create
        @board = Board.new(board_params)
        render json: @board
      end

      private
      def board_params
        params.require(:board).permit(:game_id, :player_id)
      end
    end
  end
end
