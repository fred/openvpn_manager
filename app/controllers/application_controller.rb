# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include SslRequirement
  include Clearance::Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation

  before_filter :ensure_proper_protocol
  
  def login_required
    unless current_user
      flash[:error] = "Login Required"
      redirect_to "/session/new" 
    end
  end
  
  private
  
  def ssl_required?
    Setting.get("HTTPS_ONLY") == "1"
  end
  
  def ensure_proper_protocol
    if ssl_required? && !request.ssl?
      redirect_to "https://" + request.host + request.request_uri
      flash.keep
      return false
    elsif request.ssl? && !ssl_required?
      redirect_to "http://" + request.host + request.request_uri
      flash.keep
      return false
    end
  end
  
end
