class ChangeFptsType < ActiveRecord::Migration
  def self.up
    remove_column :projections, :FPTS
    add_column :projections, :FPTS, :integer
  end

  def self.down
  end
end
