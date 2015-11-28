class AddPiecesLeftToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :pieces_left, :integer, default: 0
  end
end
