class Admin::AgenciesController < ApplicationController
  layout 'admin'
  respond_to :html, :js
  
  def index
    respond_with(@agencies = Agency.all)
  end
  
  def new
    respond_with(@agency = Agency.new)
  end
  
  def create
    @agency = Agency.new(params[:agency])
    
    if @agency.save
      respond_with @agency, :status => :created, :location => admin_agencies_path, :notice => "Skill was created successfully."
    else
      respond_with(@agency.errors, :status => :unprocessable_entity) do |format|
        format.html { render :new }
      end
    end
  end
  
  def edit
    @agency = Agency.find_by_slug(params[:id])
    respond_with @agency
  end
  
  def update
    @agency = Agency.find_by_slug(params[:id])
    @agency.update_attributes(params[:agency])
    respond_with @agency, :location => edit_admin_agency_path(@agency), :flash => "Successfully updated #{@agency.title}"
  end
  
  def destroy
    @agency = Agency.find_by_slug(params[:id])
    @agency.destroy
    respond_with @agency, :status => :destroyed, :location => admin_agencies_path, :notice => "Agency was created deleted"
  end
end
