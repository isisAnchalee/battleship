module Services
  module Games
    module Battleship
      class BattleshipGame        
        def initialize(options)
        end

        def add_second_player(id)
          @user = User.find(:id)
          @second_player = @user
        end

      end
    end
  end
end