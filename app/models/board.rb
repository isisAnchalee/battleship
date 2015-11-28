class Board < ActiveRecord::Base
  belongs_to :player
  belongs_to :game
  has_many :ships

  SHIPS = [ :cruiser, :aircraft_carrier, :battleship, :destroyer]

  def over?
    pieces_left == 0
  end
end
