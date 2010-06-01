class PostsController < ApplicationController
  caches_page :index, :show
  respond_to :html
  respond_to :atom, :only => :index
  
  def index
    @posts = Post.published
    respond_with @posts
  end
  
  def show
    @post = Post.find_by_slug(params[:id])
    @comment = Comment.new
    respond_with @post, @comment
  end
end