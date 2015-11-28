module Services
  module Games
    module Battleship
      class Water

        def initialize
        end

        def hit
          render_feedback
        end

        def render_feedback
          render json: { 'piece_hit': self.class,
                             'sound': 'splash!!!!' }
        end
      end
    end
  end
end
