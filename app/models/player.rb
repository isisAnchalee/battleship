class Player < ActiveRecord::Base
  validates :user_id, uniqueness: { scope: :game,
      message: "should happen once per year" }

  belongs_to :user
  belongs_to :game

  has_one :board
  has_many :ships

  def print_board
    board.inspect
  end

  def username
    user.username
  end
end
