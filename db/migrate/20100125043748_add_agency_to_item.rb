class AddAgencyToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :agency_id, :integer
  end

  def self.down
    remove_column :items, :agency_id
  end
end
