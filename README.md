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

### Stuff used to make this:

 * [Devise](https://github.com/plataformatec/devise) Auth
 * [Omniauth](https://github.com/arunagw/omniauth-twitter) Twitter Oauth
 * [Kaminari](https://github.com/amatsuda/kaminari) Pagination
 * [Capybara](https://github.com/jnicklas/capybara) for gzipping of data to make it fit in URLs
 * [ShouldaMatchers](https://github.com/thoughtbot/shoulda-matchers) semantic model tests
 
:shit:

