class RemovePiecesLeftFromBoards < ActiveRecord::Migration
  def change
    remove_column :boards, :pieces_left
  end
end
