class Image < ActiveRecord::Base
  belongs_to :item
  
  has_attached_file :file, :styles => {
    :small => ["250x250>", :png],
    :thumb => ["50x50#", :png]
  },
  :default_style => :thumb,
  :storage => :s3,
  :s3_credentials => File.join(Rails.root, 'config', 's3.yml'),
  :path => ":rails_env/image/:id_partition/:style_:basename.:extension",
  :url => "/uploads/:id_partition/:style_:basename.:extension"
end