module Services
  class RecordKeeper
    include Wombattleships::Redis
    
    TTL = 86400

    def initialize(options)
      @game_prefix = options.fetch(:game_prefix)
      @game_id = options.fetch(:game_id)
      @first_player_id = options.fetch(:first_player_id)
      @second_player_id = options.fetch(:second_player_id)
      @current_player = options.fetch(:current_player)
    end

    def swap_move
      @current_user = current_user == :first_player ? :second_player : :first_player
    end

    # Sets the new board in cache with 24 hour expiration time
    def store_move(board)
      redis.setex(key, TTL, board)
    end

    def get_board
      redis.get(key)
    end

    def key
      generate_redis_key(@game_prefix, @game_id, @current_player)
    end

    private
    def generate_redis_key(game, game_id, player_id)
      "#{game}:#{game_id}:#{player_id}"
    end
  end
end
