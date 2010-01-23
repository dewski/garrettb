class PostsController < ApplicationController
  layout 'blog'
  respond_to :html
  
  def index
    @posts = Post.published
  end
  
  def show
    @post = Post.find_by_slug(params[:id])
    respond_with @post
  end
end