class ApplicationController < ActionController::Base
  protect_from_forgery
  filter_parameter_logging :password
  before_filter do |controller|
    controller.send(:require_user) if ['admin'].include?(controller.class.to_s.module_name)
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  ################################################################
  # For redirecting and setting permissions
  ################################################################
  def require_user
    unless current_user
      store_location
      flash[:notice] = t("user.no_access")
      redirect_to new_user_session_url
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to account_url
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end