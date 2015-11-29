module Api
  module V1
    class GamesController < Api::V1::ApiController 
      before_action :ensure_players_belong_in_game, only: :show
      after_action :setup_boards, only: :update

      # create boards and change game state
      # after second official player found
      def update
        @game = Game.find(params[:id])
        handle_errors
        @game.second_player_id = current_user.id 
        @game.state = 'setup'
        @game.save! ? join_game : render_errors
      end

      # used to trigger board status change
      def update_status
        @game = Game.find(params[:id])
        @game.update_status(params[:status_code])
        render json: { resp: @game }
      end

      private
      def setup_boards
        @game.player_ids.each do |player_id|
          Services::BoardFactory.new({ game_id: @game.id,
                                       user_id: player_id }).build_board
        end
      end

      def render_unable_to_join
        render_message('Cannot join your own game!')
      end

      def render_game_is_full
        render_message('Game is full!')
      end

      def render_message(msg)
        render json: { message: msg } and return
      end

      def handle_errors
        render_unable_to_join if @game.first_player_id == @game.second_player_id
        render_game_is_full if @game.is_full?
      end

      def join_game
        render json: { resp: @game, start_game: true, message: 'joined game!!!'}
      end

      def render_errors
        render json: { resp: @game, message: @game.errors.full_messages }
      end
    end
  end
end
