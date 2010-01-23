class Image < ActiveRecord::Base
  belongs_to :item, :counter_cache => true
  
  has_attached_file :file, :styles => {
    :small => ["250x250>", :png],
    :thumb => ["50x50#", :png]
  },
  :default_style => :thumb
  # :path => "image/:id_partition/:style.:extension"
end