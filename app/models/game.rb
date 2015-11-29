class Game < ActiveRecord::Base

  belongs_to :first_player, class_name: 'User', foreign_key: 'first_player_id'
  belongs_to :second_player, class_name: 'User', foreign_key: 'second_player_id'
  has_one :first_player_board, class_name: 'Board', through: :first_player, source: :first_player_board
  has_one :second_player_board, class_name: 'Board', through: :second_player, source: :second_player_board
  
  validates :state, inclusion: { in: ['waiting', 'setup', 'playing', 'over'] }
  
  STATUSES = ['waiting', 'setup', 'playing', 'over']
  
  def is_full?
    second_player_id != 0
  end

  def open?
    !is_full?
  end

  def players
    [first_player, second_player]
  end

  def player_ids
    [first_player_id, second_player_id]
  end

  def update_state(status)
    update_attribute(:state, "#{Game::STATUSES[status]}")
  end
end
