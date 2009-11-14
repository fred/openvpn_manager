# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include SslRequirement
  include Clearance::Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  
  def login_required
    unless current_user
      flash[:error] = "Login Required"
      redirect_to "/session/new" 
    end
  end
  
  def ssl_required?
    Setting.get("HTTPS_ONLY") == "1"
  end
  
end
