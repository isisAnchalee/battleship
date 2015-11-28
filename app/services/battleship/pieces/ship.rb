module Services
  module Games
    module Battleship
      class Ship

        attr_accessor :sunk, :health
        attr_reader :size, :type

        def initialize(options)
          @type = self.class
          @size = options.fetch(:size)
          @health = @size
          @sunk = false
        end

        def hit
          @health -= 1
          sink! if @health == 0
          render_feedback
        end

        def render_feedback
          { 'piece_hit': self.class,
                'sound': 'splash!!!!',
               'health': @health,
                 'sunk': @sunk }
        end

        private
        
        def sink!
          @sunk = true
        end
      end
    end
  end
end
