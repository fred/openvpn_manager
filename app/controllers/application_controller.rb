# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  helper_method :current_user_session, :current_user

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  
  before_filter :openvpn_status
  
  def logged_in?
    !current_user.nil?
  end
  
  def authorized?
    logged_in? && current_user.admin?
  end
  
  def authorized_only
    redirect_to new_user_session_path unless authorized?
  end  
  
  def login_required
    unless current_user
      flash[:error] = "Login Required"
      redirect_to "/session/new" 
    end
  end
  
  def ssl_required?
    Setting.get("HTTPS_ONLY") == "1"
  end
  
  def openvpn_status
    Openvpn.status
  end
  
  
  
  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end
    
    def store_location
      if params[:return_to]
        session[:return_to] = params[:return_to]
      else
        session[:return_to] = request.request_uri
      end
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
  
  
end
