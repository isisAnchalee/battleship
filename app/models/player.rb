class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  has_one :board
  has_many :ships

  def print_board
    board.inspect
  end
end
