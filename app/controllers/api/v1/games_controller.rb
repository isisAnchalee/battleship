module Api
  module V1
    class GamesController < Api::V1::ApiController 

      def join_game
        @game = Game.find(params[:game_id])
        if @game.first_player_id == current_user.id
          render json: { resp: 'cannot join your own game' } and return 
        end
        render json: { resp: 'game is full!' } and return if @game.is_filled?
        add_user_to_game
      end

      private

      def add_user_to_game
        @game.second_player_id = current_user.id
        if @game.save!
          render json: { resp: @game, start_game: true, id: @game.id }
        else
          render json: { error: @game.errors.full_messages }
        end
      end
    end
  end
end
