class AddCurrentPlayerToGames < ActiveRecord::Migration
  def change
    add_column :games, :current_user_id, :integer
  end
end
