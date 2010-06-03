class ContactController < ApplicationController
  respond_to :html, :js
  
  def show
    
  end
  
  def create
    @contact = Mailman.contact(params[:contact]).deliver
    respond_with @contact, :location => contact_path, :status => "Successfully sent email"
  end
end