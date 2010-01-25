class ContactController < ApplicationController
  respond_to :html
  
  def show
    
  end
  
  def create
    @contact = Mailman.deliver_contact(params[:contact])
    respond_with @contact, :location => contact_path, :status => "Successfully sent email"
  end
end