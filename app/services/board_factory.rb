module Services
  class BoardFactory
    attr_reader :game_id, :user_id

    def initialize(options)
      @game_id = options.fetch(:game_id)
      @user_id = options.fetch(:user_id)
    end

    def build_board
      Board.create(board_params)
    end

    private
    def board_params
      { game_id: @game_id, user_id: @user_id }
    end
  end
end
