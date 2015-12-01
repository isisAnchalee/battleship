module Services
  class WombattleshipLogic

    attr_accessor :board
    attr_reader :game_state, :game_id, :user_id
    # this game object keeps track of the state 
    # of the board and provides an interface
    # for placing ships, playing moves and checking
    # if the game is over.
    def initialize(options)
      @game_id = options.fetch(:game_id)
      @user_id = options.fetch(:user_id)
      @game_state = options.fetch(:game_state)
      @board = options.fetch(:board)
    end

    # router for the type of move
    # depending on stored game state
    def make_move(move)
      case @game_state
      when 'waiting'
       build_response 'waiting on second player'
      when 'setup'
        place_ship(parse(move))
      when 'playing'
        play_move(parse(move))
      when 'over'
        build_response 'game over! no moves!'
      end
    end

    private

    # Public - to place the ship
    # param move [Object]
    # move[ship_sym] = integer representing ship
    # move[ship_deltas] = 2d array of ship deltas
    #
    # move = {
    #   'ship_deltas': [[0,0],[0,1],[0,2]],
    #   'ship_sym': 3
    # }
    def place_ship(move)
      ship_sym = move['ship_sym']
      move['ship_deltas'].each do |(row, col)|
        @board[row][col] = ship_sym
      end
      build_response('success', @board)
    end

    # param move [Object]
    # move[pos] = where to expose on the map
    def play_move(move)
      if valid_move?(move['pos'])
        place_move_on_board(move['pos']) 
      else 
        build_response 'Not a valid move!!!'
      end
    end

    # places new pos on board
    # returns entire board and mark
    # of most recently uncovered square
    def place_move_on_board(move)
      row, col = move
      square = @board[row][col]
      @board[row][col] = 'X'
      check_for_game_over(square)
    end

    def check_for_game_over(square)
      return build_response('GAME OVER!!', @board, square) unless game_not_over?
      build_response('success', @board, square)
    end

    # checks if board contains any 
    # ship or unmarked squares

    def game_not_over?
      @board.any? do |row|
        row.any? do |square|
          square != 0 && square != 'X'
        end
      end
    end

    def valid_move?(pos)
      within_bounds(pos[0]) && within_bounds(pos[1])
    end

    def within_bounds(n)
      n >= 0 && n < 10
    end

    def parse(str)
      JSON.parse(str)
    end

    # standardized response format
    def build_response(str, board = '', square = '')
      { game_id: @game_id,
        user_id: @user_id,
          board: board,
            str: str,
         square: square }
    end
  end
end
