# Wombattleships
Rails Battleship Game & API :100:

_Made with love by @isisAnchalee :dancer: 

### Game Structure
 Board table has serialized board column: 
 When boards_controller#update is hit, it creates a WombattleshipLogic service object that applies the move on the board
 Board is represented by 2d array of Integers and 'X's

Empty water space = 0
 Ships represented by integers based on size of ship.

ex: Destroyer = size 3 -> WombattleshipLogic#place_ship([[[0, 0], [0, 1], [0, 2]], 3]) -> board[0][0] | board[0][1] | board[0][2] = 3
 

Making a move on an enemies board places 'X' on the board and returns the ship/water's integer that was at that coordinates position.


### To Do

- Rspec API tests
- HTML5 Canvas interface
- More game logic to test for ships colliding. I would implement this by performing a deep dup on the board and checking each coordinate one by one.

### Stuff used to make this:

 * [Devise](https://github.com/plataformatec/devise) Auth
 * [Omniauth](https://github.com/arunagw/omniauth-twitter) Twitter Oauth
 * [Kaminari](https://github.com/amatsuda/kaminari) Pagination
 * [Capybara](https://github.com/jnicklas/capybara) for gzipping of data to make it fit in URLs
 * [ShouldaMatchers](https://github.com/thoughtbot/shoulda-matchers) semantic model tests
 
### Steps to test
- Check out branch -> bundle -> rake db:migrate -> start server
- Navigate to '/' and log in through twitter
- Create a game
- Sign out
- Create a new user through the /users/sign_up flow and log in
- Go to 'join games' and select the game you previously created (this puts the second player in the same game)
- Now you are in placement mode. Each user must alternate setting ship deltas with their associated integer on the opponents board. Each ship is identified on the board by integers relating to the size of the ship.


The front-end is completely responsible for making the correct number of API calls to set up each board with ships. The HTML5 canvas element will be represented as a 2d matrix of tiles representing state of the object at that node in the matrix (water, ships, etc.).

Examples in ship placement mode:
```
# ship size 2:
destroyer_move = {
 'ship_deltas': [[0,4], [0,5]],
 'ship_sym': 2
}

# ship size 3:
submarine_move = {
  'ship_deltas': [[0,0],[0,1],[0,2]],
  'ship_sym': 3
 }
 
 # ship size 4:
 battleship_move = {
 	'ship_deltas': [[2,0],[2,1],[2,2],[2,3]],
    'ship_sym': 4
 }
 
 # ship size 5
 aircraft_carrier_move = {
 	'ship_deltas': [[3,0],[3,1],[3,2],[3,3],[3,4],[3,5]],
 	'ship_sym': 5
 }
```
After all ships are placed on the board, the front end will make an API call to put '/update_status/:status_code' where status code represents a (0..3) index in a constant array.
 ```
 Game::STATUSES = ['waiting', 'setup', 'playing', 'over']
 ```

- 'Waiting': Waiting for another member to join
- 'Setup': Alternating ship placement on each board
- 'Playing': Making moves on each other's boards
- 'Over': Winner declared and the game is over

```
app/services/wombattleship_logic.rb
class WombattleshipLogic
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
end
```
After setting up all of the ships and changing the game state from 'setup' to 'playing,' make calls to the same board update method to play moves. The move logic is handled by a Wombattleship game logic service object that gets initialized with the *current version of the opponents board*, the game 'state' and the coordinate of the move being played. 

When playing a move [x, y], the game logic service object will place a flagged 'X' on the map, save the board state, and return the value of the integer that was previously there. After each turn, an iterator walks down the matrix and checks for any non-zero integer values on the board. If there are none left, that means that all ships have been exposed and the game is over.

:shit:
