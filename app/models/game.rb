class Game < ActiveRecord::Base
  belongs_to :first_player, class_name: 'User', foreign_key: 'first_player_id'
  belongs_to :second_player, class_name: 'User', foreign_key: 'second_player_id'

  def fill_game
    self.update_attribute(full: true)
  end
end

