class Board < ActiveRecord::Base
  serialize :board
  
  belongs_to :user
  belongs_to :game
  has_many :ships

  SHIPS = [ :cruiser, :aircraft_carrier, :battleship, :destroyer]

  def pieces_left?
    pieces_left > 0
  end
end
