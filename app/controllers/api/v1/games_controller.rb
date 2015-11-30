module Api
  module V1
    class GamesController < Api::V1::ApiController 
      # before_action :ensure_players_belong_in_game, only:[ :show, :update ]
      skip_before_action :authenticate_user!, only: [:update]
    
      # used to trigger board status change
      def update_status
        @game = Game.find(params[:id])
        @game.update_status(params[:status_code])
        render json: { resp: @game }
      end

      private

      def feedback_factory(msg, status = :ok, start_game = true, custom = '')
        Services::RenderFeedack.new({ msg: msg, status: status,
                              start_game: start_game, custom: custom }).render_message
      end
    end
  end
end
