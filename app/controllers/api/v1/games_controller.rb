module Api
  module V1
    class GamesController < Api::V1::ApiController 
      after_action :setup_boards, only: :update

      def create
        @game = Game.new(game_params)
        @game.first_player_id = current_user.id
        if @game.save!
          render json: { resp: @game, message: 'created game!!!'}
        else
          render json: { resp: @game, message: @game.errors.full_messages }
        end
      end

      def update
        @game = Game.find(params[:id])
        render json: { message: 'game is full!' } and return if @game.is_filled?
        @game.second_player_id = current_user.id 
        render json: { message: 'Cannot join your own game!' } and return if @game.first_player_id == @game.second_player_id
        if @game.save!
          render json: { resp: @game, message: 'joined game!!!'}
        else
          render json: { resp: @game, message: @game.errors.full_messages }
        end
      end

      private
      def setup_boards
        @game.players.each do |player|
          Services::BoardFactory.new({ game_id: @game.id,
                                       user_id: player.id}).build_board
        end
      end
    end
  end
end
