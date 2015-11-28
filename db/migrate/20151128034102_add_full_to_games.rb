class AddFullToGames < ActiveRecord::Migration
  def change
    add_column :games, :full, :boolean
  end
end
