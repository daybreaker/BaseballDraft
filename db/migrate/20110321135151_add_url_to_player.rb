class AddUrlToPlayer < ActiveRecord::Migration
  def self.up
    add_column :players, :url, :string
  end

  def self.down
    remove_column :players, :url
  end
end
