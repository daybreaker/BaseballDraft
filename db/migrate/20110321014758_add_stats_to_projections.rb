class AddStatsToProjections < ActiveRecord::Migration
  def self.up
    add_column :projections, :stats, :text
  end

  def self.down
    remove_column :projections, :stats
  end
end
