class Image < ActiveRecord::Base
  default_scope :order => 'position ASC'
  belongs_to :item, :counter_cache => true
  
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_file, :if => :cropping?
  
  has_attached_file :file, :styles => {
    :large => ["535>", :png],
    :small => ["178x114#", :png],
    :thumb => ["75x75#", :png]
  },
  :default_style => :thumb,
  :storage => :s3,
  :s3_credentials => File.join(Rails.root, 'config', 's3.yml'),
  :path => "image/:id_partition/:style.:extension"
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def file_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(file.url(style))
  end
  
  private
  
  def reprocess_file
    file.reprocess!
  end
end