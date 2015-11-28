class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.integer   :board_id
      t.string    :type
    end

    add_index :ships, :board_id
  end
end
