class ChangePlayerIdToUserId < ActiveRecord::Migration
  def change
    rename_column :boards, :player_id, :user_id
  end
end
