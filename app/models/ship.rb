class Ship < ActiveRecord::Base
  belongs_to :board
  belongs_to :player, through: :board, source: :user

  validates :type, inclusion: { in: ["cruiser", "aircraft carrier",
                                     "battleship", "destroyer"] }

end
