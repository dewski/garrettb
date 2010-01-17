class Admin::ItemsController < ApplicationController
  layout 'admin'
  respond_to :html
  
  def index
    respond_with(@items = Item.all)
  end
  
  def show
    @item = Item.find_by_slug!(params[:id])
    respond_with @item
  end
  
  def new
    respond_with(@item = Item.new)
  end
  
  def edit
    @item = Item.find_by_slug!(params[:id])
    respond_with @item
  end
  
  def update
    @item = Item.find_by_slug(params[:id])
    @item.update_attributes(params[:item])
    respond_with @item, :location => edit_admin_item_path(@item)
  end
  
  def create
    @item = Item.create(params[:item])
    respond_with @item, :location => admin_item_path(@item)
  end
end