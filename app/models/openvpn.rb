class Openvpn
  
  def self.start
    command = Setting.get("START_COMMAND")
    result = system(command)
    sleep 2
    result
  end

  def self.stop
    command = Setting.get("STOP_COMMAND")
    result = system(command)
    sleep 2
    result
  end

  def self.restart
    command = Setting.get("RESTART_COMMAND")
    result = system(command)
    sleep 2
    result
  end
    
  def self.status
    return false if 
    pid = Setting.get("PIF_FILE")
    if file.exists?(pid)
      content = File.read(file)
    end
  end
  
  # Tdod: implemet methods for BSD, OSX and other OS.
  def self.get_status
    # For now only linux to start with
    if RUBY_PLATFORM.match(/linux/)
      InstalledClient.get_linux_status
    else
      false
    end
  end
  
  
  # Get the status of the process using /proc fs
  def self.get_linux_status
    file = Setting.get("PID_FILE")
    unless File.exists?(file)
      OPENVPN_LOGGER.debug("OpenVPN: no PID file found")
      return false
    end
    pid = File.read(file).chomp
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