class PostsController < ApplicationController
  respond_to :html
  respond_to :atom, :only => :index
  
  def index
    @posts = Post.published
    respond_with @posts
  end
  
  def show
    @post = Post.find_by_slug(params[:id])
    @comment = @post.comments.build
    respond_with @post, @comment
  end
end