class Admin::CategoriesController < ApplicationController
  layout 'admin'
  respond_to :html
  
  def index
    respond_with(@categories = Category.all)
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    
  end
  
  def new
    
  end
  
  def create
    
  end
  
  def destroy
    
  end
end
