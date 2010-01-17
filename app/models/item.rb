class Item < ActiveRecord::Base
  named_scope :latest, order('created_at DESC').limit(9)
  
  before_validation :generate_slug
  has_many :images, :dependent => :destroy
  
  validates_presence_of :name
  validates_presence_of :description
  
  def thumbnail
    images.first.file.url if images.length > 0
  end
  
  def to_param
    slug
  end
  
  protected
    def generate_slug
      self.slug = name.to_slug
    end
end