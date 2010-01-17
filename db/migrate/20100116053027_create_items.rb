class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name, :required => true
      t.string :slug, :required => true
      t.text :description, :required => true

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
