class Admin::ItemsController < ApplicationController
  layout 'admin'
  respond_to :html, :xml, :json
  
  def index
    respond_with(@items = Item.order('position ASC'))
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
    @item = Item.new(params[:item])
    
    if @item.save
      respond_with @item, :status => :created, :location => admin_item_path(@item), :notice => "User was created successfully."
    else
      respond_with(@item.errors, :status => :unprocessable_entity) do |format|
        format.html {
          3.times { @item.images.build } unless @item.images.length > 0
          render :new
        }
      end
    end
  end
  
  def destroy
    @item = Item.find_by_slug(params[:id])
    @item.destroy
    respond_with @item, :status => :destroyed, :location => admin_items_path, :notice => "Item was created deleted"
  end
  
  def reorder
    params[:item].each_with_index do |id, index|
      Item.find(id).update_attribute :position, index+1
    end
  end
end