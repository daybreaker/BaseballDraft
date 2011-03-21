class RemoveExtraFieldsFromPlayersPositions < ActiveRecord::Migration
  def self.up
    remove_column :players_positions, :id
    remove_column :players_positions, :updated_at
    remove_column :players_positions, :created_at
  end

  def self.down
  end
end
