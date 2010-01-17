class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.integer :item_id, :required => true, :blank => false
      t.string :file_file_name, :required => true
      t.integer :file_file_size, :required => true
      t.string :file_file_type, :required => true
      t.timestamp :file_updated_at, :required => true
      t.integer :position, :default => 0, :required => true

      t.timestamps
    end
    
    add_index :images, :item_id
  end

  def self.down
    drop_table :images
    remove_index :images, :item_id
  end
end