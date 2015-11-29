module Services
  module Games
    module Battleship
      class WombattleshipLogic

        GAME_NAME = 'Wombattleships'

        #
        # this game object keeps track of the state 
        # of the board and provides an interface
        # for placing ships, playing moves and checking
        # if the game is over.
        #
        def initialize(options)
          @game_id = options.fetch(:game_id)
          @user_id = options.fetch(:user_id)
          @game_state = options.fetch(:game_state)
          @board = parse_grid(options.fetch(:board))
        end

        # router for the type of move
        # depending on stored game state
        def make_move(move)
          case @game_state
          when 'waiting'
            return 'waiting on second player'
          when 'setup'
            return place_ship(move)
          when 'playing'
            return play_move(move)
          when 'over'
            return 'game over! no moves!'
          end
        end

        # param move [Object]
        # move[ship_sym] = integer representing ship
        # move[ship_deltas] = 2d array of ship deltas
        # ex. [[0,0], [0,1], [0,2]]
        def place_ship(move)
          ship_sym = move[ship_sym]
          move[ship_deltas].each do |row, col|
            @board[row][col] = ship_sym
          end
        end

        # param move [Object]
        # move[pos] = where to expose on the map
        def play_move(move)
          if valid_move?(move)
            place_move_on_board(move) 
          else 
            return 'Not a valid move!!!'
          end
        end
        
        # places new pos on board
        # returns entire board and mark
        # of most recently uncovered square
        def place_move_on_board(move)
          row, col = move[pos]
          square = @board[row][col]
          @board[row][col] = 'X'
          [@board, square]
        end

        # checks if board contains any 
        # ship or unmarked squares
        def game_not_over?
          @board.each do |row|
            row.any? do |col|
              col != 0 || col != 'X'
            end
          end
        end

        def valid_move?(pos)
          within_bounds(pos[0]) && within_bounds(pos[1])
        end

        def within_bounds(n)
          n >= 0 && n < 10
        end

        def parse_grid
          @board_state = JSON.parse(@board_state)
        end
      end
    end
  end
end
