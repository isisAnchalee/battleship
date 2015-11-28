class Game < ActiveRecord::Base
  belongs_to :first_player, class_name: 'User', foreign_key: 'first_player_id'
  belongs_to :second_player, class_name: 'User', foreign_key: 'second_player_id'
  has_one :first_player_board, through: :first_player, source: :board
  has_one :second_player_board, through: :second_player, source: :board


  def second_player=(id)
    update_attribute(:second_player_id, id)
  end

  def validates_unique_players(id)
    first_player != id
  end

  def is_filled?
    first_player && second_player
  end
end

