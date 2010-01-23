class Category < ActiveRecord::Base
  has_many :posts
  before_save :generate_slug
  
  def to_param
    slug
  end
  
  protected
    def generate_slug
      self.slug = title.to_slug
    end
end
