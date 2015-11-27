module Services
  module Games
    class Battleship

      attr_reader :first_player
      attr_accessor :second_player, :map, :first_player_score, :second_player_score
      
      def initialize(options)
        @first_player = options.fetch(:first_player)
        @second_player = options.fetch(:second_player)
        @map = []
        @first_player_score = 0
        second_player_score = 0
        winner = false
      end

      def defaults(options)

      end
    end
  end
end