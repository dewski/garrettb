class Admin::PostsController < ApplicationController
  layout 'admin'
  respond_to :html
  
  def index
    respond_with(@posts = Post.all)
  end
  
  def show
    respond_with(@post = Post.find_by_slug(params[:id]))
  end
  
  def edit
    respond_with(@post = Post.find_by_slug(params[:id]))
  end
  
  def update
    @post = Post.find_by_slug(params[:id])
    @post.update_attributes(params[:post])
    respond_with @post, :location => edit_admin_post_path(@post)
  end
  
  def new
    respond_with(@post = Post.new)
  end
  
  def create
    @post = Post.new(params[:post])
    
    if @post.save
      respond_with @post, :status => :created, :location => admin_post_path(@post), :notice => "Post was created successfully"
    else
      respond_with(@post.errors, :status => :unprocessable_entity) do |format|
        format.html {
          render :new
        }
      end
    end
  end
  
  def destroy
    
  end
end
