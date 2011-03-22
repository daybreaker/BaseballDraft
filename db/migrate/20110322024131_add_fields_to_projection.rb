class AddFieldsToProjection < ActiveRecord::Migration
  def self.up
    add_column :projections, :url, :string
  end

  def self.down
    remove_column :projections, :url
  end
end
