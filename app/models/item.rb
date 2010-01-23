class Item < ActiveRecord::Base
  scope :latest, order('created_at DESC').limit(9)
  
  before_save :generate_slug
  has_many :images, :dependent => :destroy
  
  validates_presence_of :name
  validates_presence_of :description
  
  def thumbnail
    images.first
  end
  
  def to_param
    slug
  end
  
  protected
    def generate_slug
      self.slug = name.to_slug
    end
end