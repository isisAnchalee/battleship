require_relative 'level'

module Services
  module Games
    module Battleship
      class BattleshipGame

        GAME_NAME = 'Wombattleships'

        attr_accessor :players, :record_keeper, :maps, :current_player

        # Initialize game with only first player
        def initialize(options)
          @players = { first_player: Player.new(options),
                      second_player: Player.new }
          @record_keeper = options.fetch(:record_keeper)
          @maps = build_maps
          @current_player = :first_player
        end

        def add_second_player(user)
          @players[:second_player] = user
        end

        def game_over?
          @maps[:first_player].game_over?
          @maps[:second_player].game_over?
        end

        private

        def record_keeper_params(options)
          { game_id: options.fetch(:game_id),
            game_prefix: GAME_NAME }
        end

        def build_maps
          { first_player: Map.new(@record_keeper),
            second_player: Map.new(@record_keeper) }
        end

        def full_game?
          @players[:second_player].username != :temp_user
        end
      end
    end
  end
end