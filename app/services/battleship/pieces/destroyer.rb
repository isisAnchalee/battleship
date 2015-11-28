require_relative 'ship'

module Services
  module Games
    module Battleship
      class Destroyer < Ship

       DEFAULTS = {
          size: 2,
          type: self.class
        }

        def initialize(options)
          super(options.merge(DEFAULTS))
        end
      end
    end
  end
end
