class Item < ActiveRecord::Base
  scope :latest, order('created_at DESC').limit(9)
  
  has_many :images, :dependent => :destroy
  before_save :generate_slug
  
  validates_presence_of :name, :description
  
  def thumbnail
    images.order('position DESC').first
  end
  
  def to_param
    slug
  end
  
  protected
    def generate_slug
      self.slug = name.to_slug
    end
end