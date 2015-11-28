class Game < ActiveRecord::Base
  belongs_to :first_player, class_name: 'User', foreign_key: 'first_player_id'
  belongs_to :second_player, class_name: 'User', foreign_key: 'second_player_id'
  has_one :first_player_board, through: :first_player, source: :board
  has_one :second_player_board, through: :second_player, source: :board
  
  def is_filled?
    first_player && second_player
  end

  def over?
    first_player_board.over? || second_player_board.over?
  end
end
