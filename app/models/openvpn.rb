class Openvpn
  
  def self.start
    command = Setting.get("START_COMMAND")
    result = system(command)
    sleep 3
    result
  end

  def self.stop
    command = Setting.get("STOP_COMMAND")
    result = system(command)
    sleep 3
    result
  end

  def self.restart
    command = Setting.get("RESTART_COMMAND")
    result = system(command)
    sleep 3
    result
  end
  
  # Returns the pid number of the process
  # 
  def self.pid
    pid = Setting.get("PID_FILE")
    if File.exists?(pid)
      File.read(pid).chomp
    else
      nil
    end
  end
  
  # TODO: implemet methods for BSD, OSX and other OS.
  def self.status
    # For now only linux to start with
    if RUBY_PLATFORM.match(/linux/)
      Openvpn.get_linux_status
    else
      false
    end
  end
  
  # Set ENV[] for generating new openvpn certificate pairs
  def self.set_env
    Setting.all.each {|t| ENV["#{t.var}"]=t.value}
  end
  
  # Check if all require variables are set.
  def self.check_env
    result = ENV["EASY_RSA"] && 
    ENV["OPENSSL"] && 
    ENV["PKCS11TOOL"] && 
    ENV["GREP"] && 
    ENV["KEY_CONFIG"] && 
    ENV["KEY_DIR"] && 
    ENV["PKCS11_MODULE_PATH"] && 
    ENV["PKCS11_PIN"] && 
    ENV["KEY_SIZE"] && 
    ENV["CA_EXPIRE"] && 
    ENV["KEY_EXPIRE"] && 
    ENV["KEY_COUNTRY"] && 
    ENV["KEY_PROVINCE"] && 
    ENV["KEY_CITY"] && 
    ENV["KEY_ORG"] && 
    ENV["KEY_EMAIL"]
    if result
      true
    else
      false
    end
  end
  
  def self.new_client(name)
    Openvpn.set_env
    return false unless Openvpn.check_env
    easy_rsa = Setting.get("EASY_RSA")
    pkitool = "#{easy_rsa}/pkitool"
    return false unless File.exist?(pkitool)
    
    system("#{pkitool} #{name}")
  end
  
  
  # Get the status of the process using /proc fs
  def self.get_linux_status
    unless pid = Openvpn.pid
      OPENVPN_LOGGER.debug("OpenVPN: no PID file found")
      return false
    end
    proc_file = "/proc/#{pid}/status"
    if File.exists?(proc_file)
      running = true 
      OPENVPN_LOGGER.debug("OpenVPN: process is running with pid: #{pid}")
    else
      running = false
      OPENVPN_LOGGER.debug("OpenVPN: no process found with pid: #{pid}")
    end
    running
  end
  
end