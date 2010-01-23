class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :category_id, :null => false
      t.string :title, :null => false
      t.text :body, :required => true
      t.boolean :published, :default => false
      t.timestamp :published_at, :null => true
      t.timestamps
    end
    
    add_index :posts, :category_id
  end

  def self.down
    drop_table :posts
  end
end
