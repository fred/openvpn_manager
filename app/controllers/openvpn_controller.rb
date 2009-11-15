class OpenvpnController < ApplicationController 
  
  def index
  end
  
  def stop
    # do restart command
    flash[:success] = "OpenVPN stopping"
    redirect_to :action => "index"
  end
  
  def start
    # do restart command
    flash[:success] = "OpenVPN starting"
    redirect_to :action => "index"
  end
  
  def restart
    # do restart command
    flash[:success] = "OpenVPN restarting"
    redirect_to :action => "index"
  end
  
end