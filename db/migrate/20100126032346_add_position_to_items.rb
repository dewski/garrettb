class AddPositionToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :position, :integer, :default => 0
  end

  def self.down
    remove_column :items, :position
  end
end
