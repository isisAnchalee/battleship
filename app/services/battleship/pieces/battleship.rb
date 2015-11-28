require_relative 'ship'

module Services
  module Games
    module Battleship
      class Battleship < Ship

        DEFAULTS = {
          size: 4,
          type: self.class
        }

        def initialize(options)
          super(options.merge(DEFAULTS))
        end
      end
    end
  end
end
