class Admin::ImagesController < ApplicationController
  layout 'admin'
  respond_to :html
  before_filter :find_current_item
  
  def index
    
  end
  
  def new
    respond_with(@image = Image.new)
  end
  
  def create
    @image = Image.new(params[:image])
    @image.item = @item
    
    if @image.save
      respond_with @image, :status => :created, :location => admin_item_image_path(@item, @image)
    else
      respond_with(@image.errors, :status => :unprocessable_entity) do |format|
        format.html { render :new }
      end
    end
  end
  
  def show
    @image = Image.where("item_id = #{@item.id}").find(params[:id])
    respond_with @image
  end
  
  protected
    def find_current_item
      @item = Item.find_by_slug(params[:item_id])
    end
end