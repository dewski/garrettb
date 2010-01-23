class Image < ActiveRecord::Base
  belongs_to :item, :counter_cache => true
  
  has_attached_file :file, :styles => {
    :large => ["805>", :png],
    :small => ["178x114#", :png],
    :thumb => ["75x75#", :png]
  },
  :default_style => :thumb,
  :storage => :s3,
  :s3_credentials => File.join(Rails.root, 'config', 's3.yml'),
  :path => "image/:id_partition/:style.:extension"
end