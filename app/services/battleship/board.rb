module Services
  module Games
    module Battleship
      class Board

        TOTAL_SHIPS = 4

        PIECES = [:aircraft_carrier,
                  :battleship,
                  :cruiser,
                  :destroyer]

        attr_accessor :map, :pieces

        def initialize(options)
          @pieces = []
          @map = Array.new(10){ Array.new(10, 0) }
          @sunken = 0
        end

        def valid_move?(pos)
          return false unless pos
          valid_range?(pos[0]) && valid_range?(pos[1])
        end

        def valid_range?(n)
          n < 10 && n >= 0
        end

        def game_over?
          @sunken >= TOTAL_SHIPS
        end
      end
    end
  end
end