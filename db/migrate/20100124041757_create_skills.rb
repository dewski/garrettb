class CreateSkills < ActiveRecord::Migration
  def self.up
    create_table :skills do |t|
      t.string :title, :null => false
      t.string :slug, :null => false

      t.timestamps
    end
    
    create_table :items_skills, :id => false do |t|
      t.integer :item_id
      t.integer :skill_id
    end
    
    add_index :skills, :slug
    add_index :items_skills, :item_id
    add_index :items_skills, :skill_id
  end

  def self.down
    drop_table :skills
    drop_table :items_skills
  end
end
