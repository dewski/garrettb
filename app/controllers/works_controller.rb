class WorksController < ApplicationController
  # layout 'detail', :only => :show
  respond_to :html
  
  def index
    @items = Item.all
    respond_with @items
  end
  
  def show
    @item = Item.find_by_slug(params[:id])
    respond_with @item
  end
end
