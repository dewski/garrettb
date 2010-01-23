class RenameFileFileType < ActiveRecord::Migration
  def self.up
    rename_column :images, :file_file_type, :file_content_type
  end

  def self.down
    rename_column :images, :file_content_type, :file_file_type
  end
end
