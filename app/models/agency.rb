class Agency < ActiveRecord::Base
  before_save :generate_slug
  
  has_many :items
  
  validates_presence_of :title
  validates_format_of :url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  
  def to_param
    slug
  end
  
  protected
    def generate_slug
      self.slug = title.to_slug
    end
end
