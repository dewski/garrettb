class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :title
      t.string :slug
      t.timestamps
    end
    
    add_index :categories, :slug
  end

  def self.down
    drop_table :categories
  end
end
