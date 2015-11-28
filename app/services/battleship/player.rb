module Services
  module Games
    module Battleship
      class Player

        attr_reader :username

        def initialize(options)
          @username = options.fetch(:username, :temp_user)
        end
      end
    end
  end
end