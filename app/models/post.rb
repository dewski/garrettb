class Post < ActiveRecord::Base
  scope :published, where('published = 1').order('published_at DESC').includes(:category)
  
  belongs_to :category
  has_many :comments
  
  before_save :generate_slug, :set_published_at
  validates_associated :comments
  
  def to_param
    slug
  end
  
  protected
    def generate_slug
      self.slug = title.to_slug
    end
    
    def set_published_at
      # It's already been published, don't change the date.
      return if self.published_at.present?
      self.published_at = (self.published? ? Time.now : nil)
    end
end