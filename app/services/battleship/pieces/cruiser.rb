require_relative 'ship'

module Services
  module Games
    module Battleship
      class Cruiser < Ship

        DEFAULTS = {
          size: 3,
          type: self.class
        }

        def initialize(options)
          super(options.merge(DEFAULTS))
        end
      end
    end
  end
end
