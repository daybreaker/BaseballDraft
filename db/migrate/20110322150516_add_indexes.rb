class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :players_positions, :player_id
    add_index :players_positions, :position_id
    add_index :positions, :abbr
    add_index :projections, :player_id
  end

  def self.down
  end
end
