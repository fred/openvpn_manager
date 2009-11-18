class OpenvpnController < ApplicationController 
  
  def index
  end
  
  def stop
    result = Openvpn.stop
    if result == false
      flash[:error] = "OpenVPN stopping failed."
    else
      flash[:success] = "OpenVPN is stopping."
    end
    redirect_to :action => "index"
  end
  
  def start
    result = Openvpn.start
    if result == false
      flash[:error] = "OpenVPN starting failed."
    else
      flash[:success] = "OpenVPN is starting."
    end
    redirect_to :action => "index"
  end
  
  def restart
    result = Openvpn.restart
    if result == false
      flash[:error] = "OpenVPN restarting failed."
    else
      flash[:success] = "OpenVPN is restarting."
    end
    redirect_to :action => "index"
  end
  
end