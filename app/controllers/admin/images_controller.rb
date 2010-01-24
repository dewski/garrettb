class Admin::ImagesController < ApplicationController
  layout 'admin'
  
  respond_to :html, :js
  before_filter :find_current_item
  
  def index
    @images = @item.images.order("position ASC")
    respond_with @images
  end
  
  def new
    respond_with(@image = Image.new)
  end
  
  def create
    @image = Image.new(params[:image])
    @image.item = @item
    
    if @image.save
      respond_with @image, :status => :created, :location => admin_item_images_path(@item)
    else
      respond_with(@image.errors, :status => :unprocessable_entity) do |format|
        format.html { render :new }
      end
    end
  end
  
  def crop
    @image = Image.find(params[:id])
    respond_with @image
  end
  
  def update
    @image = Image.find(params[:id])
    @image.update_attributes(params[:image])
    
    if @image.save
      respond_with @image, :status => :created, :location => admin_item_images_path(@item)
    else
      respond_with(@image.errors, :status => :unprocessable_entity) do |format|
        format.html { render :crop }
      end
    end
  end
  
  def show
    @image = Image.where("item_id = #{@item.id}").find(params[:id])
    respond_with @image
  end
  
  def reorder
    params[:image].each_with_index do |id, index|
      Image.find(id).update_attribute :position, index+1
    end
  end
  
  protected
    def find_current_item
      @item = Item.find_by_slug(params[:item_id])
    end
end