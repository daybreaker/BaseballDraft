class CreateProjections < ActiveRecord::Migration
  def self.up
    create_table :projections do |t|
      t.integer :player_id
      t.integer :year
      t.string :site
      t.integer :stats_id

      t.timestamps
    end
  end

  def self.down
    drop_table :projections
  end
end
