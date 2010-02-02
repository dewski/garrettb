class Comment < ActiveRecord::Base
  belongs_to :post, :counter_cache => true
  
  validates_presence_of :name, :email, :body
end