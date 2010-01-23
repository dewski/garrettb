class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :post_id, :null => false
      t.string :email, :null => false
      t.string :name
      t.string :body, :null => false
      t.timestamps
    end
    
    add_index :comments, :post_id
  end

  def self.down
    drop_table :comments
  end
end
