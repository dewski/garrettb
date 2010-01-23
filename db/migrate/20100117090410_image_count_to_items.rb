class ImageCountToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :images_count, :integer, :default => 0
    
    Item.all.each do |item|
      item.update_attribute(:images_count, item.images.length)
    end
  end

  def self.down
    remove_column :items, :images_count
  end
end
