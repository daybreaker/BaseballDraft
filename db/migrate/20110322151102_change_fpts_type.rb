class ChangeFptsType < ActiveRecord::Migration
  def self.up
    change_column :projections, :FPTS, :integer
  end

  def self.down
  end
end
