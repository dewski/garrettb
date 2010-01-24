class Item < ActiveRecord::Base
  scope :latest, order('created_at DESC').limit(9)
  
  has_many :images, :dependent => :destroy
  before_save :generate_slug
  
  has_and_belongs_to_many :skills
  
  validates_presence_of :name, :description
  validates_format_of :url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  
  def thumbnail
    images.order('position ASC').first
  end
  
  def to_param
    slug
  end
  
  protected
    def generate_slug
      self.slug = name.to_slug
    end
end