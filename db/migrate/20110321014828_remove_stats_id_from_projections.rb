class RemoveStatsIdFromProjections < ActiveRecord::Migration
  def self.up
    remove_column :projections, :stats_id
  end
  
  def self.down
    add_column :projections, :stats_id, :integer
  end
end
