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
  
  def step1
  end

  def step2
    Openvpn.set_env
    @result = Openvpn.check_env
    error = "Check settings."
    update_result(@result,error)
  end

  def step3
    command = "cp -a /usr/share/openvpn/easy-rsa/ /etc/openvpn/"
    @result = system(command)
    error = $?
    update_result(@result,error)
  end

  def step4
    command = "/etc/openvpn/easy-rsa/clean-all"
    @result = system(command)
    error = $?
    update_result(@result,error)
  end

  def step5
    command = "/etc/openvpn/easy-rsa/build-ca"
    @result = system(command)
    error = $?
    update_result(@result,error)
    
  end

  def step6
    command = "/etc/openvpn/easy-rsa/build-key-server server"
    @result = system(command)
    error = $?
    update_result(@result,error)
  end
  
  def step7
    command = "/etc/openvpn/easy-rsa/build-dh"
    @result = system(command)
    error = $?
    update_result(@result,error)
  end
  
  def update_result(result,error)
    num = params[:step]
    @result = result
    render :update do |page|
      if result == true
        page.hide  "step#{num}"
        page.replace_html "step#{num}_result", "<span class=result_#{@result}> Success.</span>"
      else
        page.replace_html "step#{num}_result", "<span class=result_#{@result}> Error #{error}.</span>"
      end
      page.visual_effect :highlight, "step#{num}_result"
    end
  end
end