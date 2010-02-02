class CommentsController < ApplicationController
  respond_to :html, :js
  
  def create
    @post = Post.find_by_slug(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    
    if @comment.save
      respond_with @comment, :status => :created, :location => admin_skills_path, :notice => "Skill was created successfully."
    else
      respond_with(@comment.errors, :status => :unprocessable_entity) do |format|
        format.html { render :new }
      end
    end
  end
end
