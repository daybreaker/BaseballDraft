class AddAbbrToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :abbr, :string
  end

  def self.down
    remove_column :teams, :abbr
  end
end
