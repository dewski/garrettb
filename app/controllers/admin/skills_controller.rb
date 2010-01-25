class Admin::SkillsController < ApplicationController
  layout 'admin'
  respond_to :html, :js
  
  def index
    @skills = Skill.all
    respond_with @skills
  end
  
  def new
    respond_with(@skill = Skill.new)
  end
  
  def create
    @skill = Skill.new(params[:skill])
    
    if @skill.save
      respond_with @skill, :status => :created, :location => admin_skills_path, :notice => "Skill was created successfully."
    else
      respond_with(@skill.errors, :status => :unprocessable_entity) do |format|
        format.html { render :new }
      end
    end
  end
  
  def edit
    @skill = Skill.find_by_slug(params[:id])
    respond_with @skill
  end
  
  def update
    @skill = Skill.find_by_slug(params[:id])
    @skill.update_attributes(params[:skill])
    respond_with @skill, :location => edit_admin_skill_path(@skill)
  end
  
  def destroy
    @skill = Skill.find_by_slug(params[:id])
    @skill.destroy
    respond_with @skill, :status => :destroyed, :location => admin_skills_path, :notice => "Skill was created deleted"
  end
end
