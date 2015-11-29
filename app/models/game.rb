#  class PlayerValidater < ActiveModel::Validator
#   def validate(record)
#     unless record.first_player_id != record.second_player_id
#       record.errors[:second_player_id] << 'Cannot join your own game!'
#     end
#   end
# end
class Game < ActiveRecord::Base
  belongs_to :first_player, class_name: 'User', foreign_key: 'first_player_id'
  belongs_to :second_player, class_name: 'User', foreign_key: 'second_player_id'
  has_one :first_player_board, class_name: 'Board', through: :first_player, source: :first_player_board
  has_one :second_player_board, class_name: 'Board', through: :second_player, source: :second_player_board
  
  # include ActiveModel::Validations
  # validates_with PlayerValidater
  
  def is_filled?
    second_player_id != 0
  end

  def open?
    !is_filled?
  end

  def over?
    first_player_board.over? || second_player_board.over?
  end

  def unique_players
    first_player_id != second_player_id
  end

  def players
    [first_player, second_player]
  end
end
