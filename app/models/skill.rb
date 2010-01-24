class Skill < ActiveRecord::Base
  has_and_belongs_to_many :items
  before_validation :generate_slug
  
  validates_presence_of :title, :slug
  
  def to_param
    slug
  end
  
  protected
    def generate_slug
      self.slug = title.to_slug
    end
end
