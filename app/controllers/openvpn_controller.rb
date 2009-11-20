class OpenvpnController < ApplicationController 
  
  def index
    @easy_rsa = Setting.get("EASY_RSA")
    @log_folder = Setting.get("LOG_FILE").gsub("openvpn.log", "")
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
  
  # Will check if system has tun/tap module or kernel support
  def step1
    command = "modprobe tun"
    system(command)
    command_tun = "find /dev/ -name 'tun'"
    @result = system(command_tun)
    error = "#{$?}, Your Kernel has no support for the TUN driver, you need to build a module or install it."
    msg = "your kernel has TUN support. :)"
    update_result(@result,error,msg)
  end

  def step2
    Openvpn.set_env
    @result = Openvpn.check_env
    error = "Check your settings."
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
    Openvpn.set_env
    easy_rsa = Setting.get("EASY_RSA")
    command = "#{easy_rsa}/pkitool --initca"
    @result = system(command)
    error = $?
    update_result(@result,error)
    
  end

  def step6
    Openvpn.set_env
    easy_rsa = Setting.get("EASY_RSA")
    command = "#{easy_rsa}/pkitool --server server"
    @result = system(command)
    error = $?
    update_result(@result,error)
  end
  
  def step7
    Openvpn.set_env
    easy_rsa = Setting.get("EASY_RSA")
    command = "#{easy_rsa}/build-dh"
    @result = system(command)
    error = $?
    update_result(@result,error)
  end
  
  def step8
    count = Openvpn.write_config_file
    error = nil
    if count.to_i > 0
      @result = true
      msg = "#{count} bytes written to file."
    else
      @result = false
      error = "Error, could not write to file"
    end
    update_result(@result,error,msg)
  end
  
  def step9
    @log_folder = Setting.get("LOG_FILE").gsub("openvpn.log", "")
    @result = system("mkdir -p #{@log_folder}")
    error = "#{$?} You may have no permissions. Check is this process is running as root."
    update_result(@result,error)
  end
  
  def update_result(result,error=nil,msg=nil)
    num = params[:step]
    @result = result
    render :update do |page|
      if result == true
        page.hide  "step#{num}"
        page.insert_html :bottom, "step#{num}_result", "<span class=result_#{@result}> Success. #{msg}</span><br />"
      else
        page.insert_html :bottom, "step#{num}_result", "<span class=result_#{@result}> Error #{error}.</span><br />"
      end
      page.visual_effect :highlight, "step#{num}_result"
    end
  end
end
