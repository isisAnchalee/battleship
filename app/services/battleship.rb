module Services
  module Games
    class Battleship
      attr_reader :first_player
      attr_accessor :second_player, :map, :first_player_score, :second_player_score
      
      def initialize(options)
        @first_player = options.fetch(:first_player)
        @second_player = false
        @map = []
        @first_player_score = 0
        second_player_score = 0
        winner = false
      end

      def add_second_player(id)
        @user = User.find(:id)
        @second_player = @user
      end
    end
  end
end