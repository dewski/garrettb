class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [ :new, :create ]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    
    @user_session.save do |result|
      if result
        redirect_to root_path, :notice => "Login successful!"
      else
        render :new
      end
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    redirect_to root_url, :notice => "Successfully logged out."
  end
end
