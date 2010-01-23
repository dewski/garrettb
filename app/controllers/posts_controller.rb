class PostsController < ApplicationController
  layout 'blog'
  respond_to :html
  respond_to :atom, :only => :index
  
  def index
    @posts = Post.published
    respond_with @posts
  end
  
  def show
    @post = Post.find_by_slug(params[:id])
    respond_with @post
  end
end