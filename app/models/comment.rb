class Comment < ActiveRecord::Base
  belongs_to :post, :counter_cache => true
  
  validates_presence_of :name, :email, :body
  
  def gravatar_email
    email.downcase
  end
  
  def gravatar_id
    Digest::MD5.hexdigest(gravatar_email)
  end
  
  def gravatar(size=50, default=nil)
    url = "http://www.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    url += "&d=#{default}" if default
    url
  end
end