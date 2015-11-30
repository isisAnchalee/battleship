# Wombattleships
Rails Battleship Game & API :100:

_Made with love by @isisAnchalee :dancer: 

### Game Structure
 Board is represented by 2d array of Integers and 'X's

Empty water space = 0
 Ships represented by integers based on size of ship.

ex: Destroyer = size 3 -> #place_ship([[[0, 0], [0, 1], [0, 2]], 3]) -> board[0][0] | board[0][1] | board[0][2] = 3
 

Making a move on an enemies board places 'X' on the board and returns the ship/water's integer that was at that coordinates position.


### To Do

- Rspec API tests
- HTML5 Canvas interface

:shit:
