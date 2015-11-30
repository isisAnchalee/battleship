class DropFullColumnFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :full
  end
end
