class CreateAgencies < ActiveRecord::Migration
  def self.up
    create_table :agencies do |t|
      t.string :title, :null => false
      t.string :slug, :null => false
      t.string :url
      t.timestamps
    end
  end

  def self.down
    drop_table :agencies
  end
end
