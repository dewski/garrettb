class Admin::ItemsController < ApplicationController
  layout 'admin'
  respond_to :html, :xml, :json
  
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
    @item = Item.new(params[:item])
    
    if @item.save
      flash[:notice] = "User was created successfully."
      respond_with @item, :status => :created, :location => admin_item_path(@item)
    else
      respond_with(@item.errors, :status => :unprocessable_entity) do |format|
        format.html {
          3.times { @item.images.build } unless @item.images.length > 0
          render :new
        }
      end
    end
  end
end