class Admin::ImagesController < ApplicationController
  layout 'admin'
  before_filter :find_current_item
  
  def index
    
  end
  
  protected
    def find_current_item
      @item = Item.find_by_slug(params[:item_id])
    end
end