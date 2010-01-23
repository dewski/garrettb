class Post < ActiveRecord::Base
  scope :published, where("published = 1").order("published_at DESC").includes(:category)
  
  belongs_to :category
  has_many :comments
  
  before_save :generate_slug
  validates_associated :comments
  
  def to_param
    slug
  end
  
  protected
    def generate_slug
      self.slug = title.to_slug
    end
end
