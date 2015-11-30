class Board < ActiveRecord::Base

  SHIP_DEFINITIONS = {
    aircraft_carrier: 5,
    battleship: 4,
    submarine: 3,
    destroyer: 2,
  }

  serialize :board
  belongs_to :user
  belongs_to :game
  
end
