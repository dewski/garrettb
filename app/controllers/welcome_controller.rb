class WelcomeController < ApplicationController
  def index
    @items = Item.where("images_count > 0").limit(9)
    @posts = Post.where("published = 1").order("published_at DESC").limit(3)
  end
end