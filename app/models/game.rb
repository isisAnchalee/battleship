class Game < ActiveRecord::Base

  belongs_to :first_player, class_name: 'User', foreign_key: 'first_player_id'
  belongs_to :second_player, class_name: 'User', foreign_key: 'second_player_id'
  has_one :first_player_board, class_name: 'Board', through: :first_player, source: :first_player_board
  has_one :second_player_board, class_name: 'Board', through: :second_player, source: :second_player_board
  
  scope :open_games, -> (id, fid) { where("first_player_id = ? or second_player_id = ?", id, fid) }

  validates :room_name, presence: true
  validates :state, inclusion: { in: ['waiting', 'setup', 'playing', 'over'] }
  
  STATUSES = ['waiting', 'setup', 'playing', 'over']
  PLACEHOLDER_ID = 0

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

  def toggle_current_player
    if current_user_id == first_player_id
      current_user_id = second_player_id
    else
      current_user_id = first_player_id
    end
  end
end
