module Api
  module V1
    class GamesController < Api::V1::ApiController 
      before_action :ensure_players_belong_in_game, only:[ :show, :update ]

      after_action :setup_boards, only: :update

      # create boards and change game state
      # after second official player found
      def update
        @game = Game.find(params[:id])
        handle_errors
        @game.second_player_id = current_user.id 
        @game.state = 'setup'
        @game.save! ? join_game : render_game_errors
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

      def feedback_factory(msg, status = :ok, start_game = true, custom = '')
        Services::BoardFactory.new({ msg: msg, status: status,
                              start_game: start_game, custom: custom }).render_message
      end

      def handle_errors
        message = :cannot_join if @game.first_player_id == @game.second_player_id
        message = :game_is_full if @game.is_full?
        feedback_factory(message).render_message
      end

      def join_game
        feedback_factory(:joined_game).render_message
      end

      def render_game_errors
        feedback_factory(msg: '', :ok, true, custom: @game.errors.full_messages).render_message
      end

      def ensure_players_belong_in_game
        render_401 unless @game && @game.player_ids.include?(params[:user_id])
      end

      def render_401
        feedback_factory(msg: :unauthorized, :unauthorized, false).render_message
      end
    end
  end
end
