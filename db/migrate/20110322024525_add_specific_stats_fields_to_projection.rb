class AddSpecificStatsFieldsToProjection < ActiveRecord::Migration
  def self.up
    ["FPTS", "INN", "GS", "QS", "CG", "W", "L", "S", "BS", "K", "BBI", "HA", "ERA", "WHIP", "AB", "R", "H", "H1B", "H2B", "H3B", "HR", "RBI", "BB", "KO", "SB", "CS", "BA", "OBP", "SLG"] .each do |x|
      add_column :projections, x, :string
    end
    remove_column :projections, :stats
  end

  def self.down
    ["FPTS", "INN", "GS", "QS", "CG", "W", "L", "S", "BS", "K", "BBI", "HA", "ERA", "WHIP", "AB", "R", "H", "H1B", "H2B", "H3B", "HR", "RBI", "BB", "KO", "SB", "CS", "BA", "OBP", "SLG"] .each do |x|
      remove_column :projections, x
    end
    add_column :projections, :stats, :string
  end
end
