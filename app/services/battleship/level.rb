module Services
  module Games
    module Battleship
      class Level

        # attr_reader :num_ships
        attr_accessor :map
        def initialize(options)
          # @num_ships = options.fetch(:num_ships)
          @map = build_map(@num_ships)
        end
      end
    end
  end
end