class CreatePlayersPositions < ActiveRecord::Migration
  def self.up
    create_table :players_positions do |t|
      t.integer :player_id
      t.integer :position_id

      t.timestamps
    end
  end

  def self.down
    drop_table :players_positions
  end
end
