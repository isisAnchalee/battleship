class ChangeDefaultStateColumn < ActiveRecord::Migration
  def change
    change_column :games, :state, :string, default: 'waiting'
  end
end
