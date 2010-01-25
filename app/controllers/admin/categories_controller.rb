class Admin::CategoriesController < ApplicationController
  layout 'admin'
  respond_to :html, :js
  
  def index
    respond_with(@categories = Category.all)
  end
  
  def edit
    respond_with(@category = Skill.find_by_slug(params[:id]))
  end
  
  def update
    @category = Category.find_by_slug(params[:id])
    @category.update_attributes(params[:skill])
    respond_with @category, :location => edit_admin_category_path(@category), :notice => "#{@category.title} was updated"
  end
  
  def new
    respond_with(@category = Category.new)
  end
  
  def create
    @category = Category.new(params[:category])
    
    if @category.save
      respond_with @category, :status => :created, :location => admin_categories_path, :notice => "Category was created successfully."
    else
      respond_with(@category.errors, :status => :unprocessable_entity) do |format|
        format.html { render :new }
      end
    end
  end
  
  def destroy
    @category = Category.find_by_slug(params[:id])
    @category.destroy
    respond_with @category, :status => :destroyed, :location => admin_categories_path, :notice => "Category was created deleted"
  end
end
