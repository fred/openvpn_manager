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
  
  # Check if all require variables are set 
  # for generating the new config file
  def self.check_settings
    result = Setting.get("KEY_DIR") && 
    Setting.get("IPP_FILE") && 
    Setting.get("port") && 
    Setting.get("protocol") && 
    Setting.get("interface_device") && 
    Setting.get("server_network") && 
    Setting.get("server_ip") && 
    Setting.get("port") && 
    Setting.get("ccd") && 
    Setting.get("redirect_gateway") && 
    Setting.get("cipher") && 
    Setting.get("comp_lzo") && 
    Setting.get("max_clients") && 
    Setting.get("STATUS_LOG") && 
    Setting.get("LOG_FILE") && 
    Setting.get("verbosity") && 
    Setting.get("client_to_client")
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
  
  
  def self.write_config_file
    # First create a backup with a timestamp
    date = Time.now.strftime("%Y%m%d%H%M%S")
    destination = "/etc/openvpn/openvpn.conf"
    if File.exists?(destination)
      FileUtils.mv(destination,"#{destination}.bak_#{date}")
    end
    filedata = Openvpn.config_file
    tmp = File.new(destination, "w+")
    tmp.write(filedata.result)
  end
  
  def self.config_file
    return false unless Openvpn.check_settings
    key_dir = Setting.get("KEY_DIR")
    ipp_file = Setting.get("IPP_FILE")
    
    port = Setting.get("port")
    proto = Setting.get("protocol")
    dev = Setting.get("interface_device")
    server_network = Setting.get("server_network")
    server_ip = Setting.get("server_ip")
    keepalive = Setting.get("keepalive")
    ccd = Setting.get("ccd")
    redirect_gateway = Setting.get("redirect_gateway")=="1"
    cipher = Setting.get("cipher")
    comp_lzo = Setting.get("comp_lzo")
    max_clients = Setting.get("max_clients")
    status_file = Setting.get("STATUS_LOG")
    log_file = Setting.get("LOG_FILE")
    verbosity = Setting.get("verbosity")
    client_to_client = Setting.get("client_to_client")=="1"
    
    file = ERB.new <<-EOF
#################################################
# GENERATED ON: #{Time.now.to_s(:long)}
#################################################
# Sample OpenVPN 2.0 config file for            #
# multi-client server.                          #
#                                               #
# This file is for the server side              #
# of a many-clients <-> one-server              #
# OpenVPN configuration.                        #
#                                               #
# OpenVPN also supports                         #
# single-machine <-> single-machine             #
# configurations (See the Examples page         #
# on the web site for more info).               #
#                                               #
# This config should work on Windows            #
# or Linux/BSD systems.  Remember on            #
# Windows to quote pathnames and use            #
# double backslashes, e.g.:                     #
# "C:\\Program Files\\OpenVPN\\config\\foo.key" #
#                                               #
# Comments are preceded with '#' or ';'         #
#################################################

# Which local IP address should OpenVPN
# listen on? (optional)
#;local a.b.c.d

# Which TCP/UDP port should OpenVPN listen on?
# If you want to run multiple OpenVPN instances
# on the same machine, use a different port
# number for each one.  You will need to
# open up this port on your firewall.
#port 1194
port #{port}  ### GENERATED

# TCP or UDP server?
#;proto tcp
#proto udp
proto #{proto} ### GENERATED

# "dev tun" will create a routed IP tunnel,
# "dev tap" will create an ethernet tunnel.
# Use "dev tap0" if you are ethernet bridging
# and have precreated a tap0 virtual interface
# and bridged it with your ethernet interface.
# If you want to control access policies
# over the VPN, you must create firewall
# rules for the the TUN/TAP interface.
# On non-Windows systems, you can give
# an explicit unit number, such as tun0.
# On Windows, use "dev-node" for this.
# On most systems, the VPN will not function
# unless you partially or fully disable
# the firewall for the TUN/TAP interface.
#;dev tap
#;dev tun
dev #{dev} ### GENERATED

# Windows needs the TAP-Win32 adapter name
# from the Network Connections panel if you
# have more than one.  On XP SP2 or higher,
# you may need to selectively disable the
# Windows firewall for the TAP adapter.
# Non-Windows systems usually don't need this.
#;dev-node MyTap

# SSL/TLS root certificate (ca), certificate
# (cert), and private key (key).  Each client
# and the server must have their own cert and
# key file.  The server and all clients will
# use the same ca file.
#
# See the "easy-rsa" directory for a series
# of scripts for generating RSA certificates
# and private keys.  Remember to use
# a unique Common Name for the server
# and each of the client certificates.
#
# Any X509 key management system can be used.
# OpenVPN can also use a PKCS #12 formatted key file
# (see "pkcs12" directive in man page).
# ca ca.crt
# cert server.crt
# key server.key  # This file should be kept secret
ca #{key_dir}/ca.crt  ### GENERATED
cert #{key_dir}/server.crt  ### GENERATED
key #{key_dir}/server.key  # This file should be kept secret  ### GENERATED

# Diffie hellman parameters.
# Generate your own with:
#   openssl dhparam -out dh1024.pem 1024
# Substitute 2048 for 1024 if you are using
# 2048 bit keys. 
# dh dh1024.pem
dh #{key_dir}/dh1024.pem  ### GENERATED


# Configure server mode and supply a VPN subnet
# for OpenVPN to draw client addresses from.
# The server will take 10.8.0.1 for itself,
# the rest will be made available to clients.
# Each client will be able to reach the server
# on 10.8.0.1. Comment this line out if you are
# ethernet bridging. See the man page for more info.
# server 10.8.0.0 255.255.255.0
server #{server_network}  ### GENERATED

# ifconfig 10.8.0.1 10.8.0.2
ifconfig #{server_ip}  ### GENERATED

# Maintain a record of client <-> virtual IP address
# associations in this file.  If OpenVPN goes down or
# is restarted, reconnecting clients can be assigned
# the same virtual IP address from the pool that was
# previously assigned.
# ifconfig-pool-persist ipp.txt
ifconfig-pool-persist #{ipp_file}  ### GENERATED

# Configure server mode for ethernet bridging.
# You must first use your OS's bridging capability
# to bridge the TAP interface with the ethernet
# NIC interface.  Then you must manually set the
# IP/netmask on the bridge interface, here we
# assume 10.8.0.4/255.255.255.0.  Finally we
# must set aside an IP range in this subnet
# (start=10.8.0.50 end=10.8.0.100) to allocate
# to connecting clients.  Leave this line commented
# out unless you are ethernet bridging.
#;server-bridge 10.8.0.4 255.255.255.0 10.8.0.50 10.8.0.100

# Push routes to the client to allow it
# to reach other private subnets behind
# the server.  Remember that these
# private subnets will also need
# to know to route the OpenVPN client
# address pool (10.8.0.0/255.255.255.0)
# back to the OpenVPN server.
#;push "route 192.168.10.0 255.255.255.0"
#;push "route 192.168.20.0 255.255.255.0"

# To assign specific IP addresses to specific
# clients or if a connecting client has a private
# subnet behind it that should also have VPN access,
# use the subdirectory "ccd" for client-specific
# configuration files (see man page for more info).

# EXAMPLE: Suppose the client
# having the certificate common name "Thelonious"
# also has a small subnet behind his connecting
# machine, such as 192.168.40.128/255.255.255.248.
# First, uncomment out these lines:
#;client-config-dir ccd
#;route 192.168.40.128 255.255.255.248
# Then create a file ccd/Thelonious with this line:
#   iroute 192.168.40.128 255.255.255.248
# This will allow Thelonious' private subnet to
# access the VPN.  This example will only work
# if you are routing, not bridging, i.e. you are
# using "dev tun" and "server" directives.

# EXAMPLE: Suppose you want to give
# Thelonious a fixed VPN IP address of 10.9.0.1.
# First uncomment out these lines:
#;client-config-dir ccd
#;route 10.9.0.0 255.255.255.252
# Then add this line to ccd/Thelonious:
#   ifconfig-push 10.9.0.1 10.9.0.2

client-config-dir #{ccd}  ### GENERATED

# Suppose that you want to enable different
# firewall access policies for different groups
# of clients.  There are two methods:
# (1) Run multiple OpenVPN daemons, one for each
#     group, and firewall the TUN/TAP interface
#     for each group/daemon appropriately.
# (2) (Advanced) Create a script to dynamically
#     modify the firewall in response to access
#     from different clients.  See man
#     page for more info on learn-address script.
#;learn-address ./script

# If enabled, this directive will configure
# all clients to redirect their default
# network gateway through the VPN, causing
# all IP traffic such as web browsing and
# and DNS lookups to go through the VPN
# (The OpenVPN server machine may need to NAT
# the TUN/TAP interface to the internet in
# order for this to work properly).
# CAVEAT: May break client's network config if
# client's local DHCP server packets get routed
# through the tunnel.  Solution: make sure
# client's local DHCP server is reachable via
# a more specific route than the default route
# of 0.0.0.0/0.0.0.0.
#;push "redirect-gateway"
#{"push \"redirect-gateway\"  ### GENERATED" if redirect_gateway }

# Certain Windows-specific network settings
# can be pushed to clients, such as DNS
# or WINS server addresses.  CAVEAT:
# http://openvpn.net/faq.html#dhcpcaveats
#;push "dhcp-option DNS 10.8.0.1"
#;push "dhcp-option WINS 10.8.0.1"

# Uncomment this directive to allow different
# clients to be able to "see" each other.
# By default, clients will only see the server.
# To force clients to only see the server, you
# will also need to appropriately firewall the
# server's TUN/TAP interface.
#;client-to-client
#{"client-to-client  ### GENERATED" if client_to_client}

# Uncomment this directive if multiple clients
# might connect with the same certificate/key
# files or common names.  This is recommended
# only for testing purposes.  For production use,
# each client should have its own certificate/key
# pair.
#
# IF YOU HAVE NOT GENERATED INDIVIDUAL
# CERTIFICATE/KEY PAIRS FOR EACH CLIENT,
# EACH HAVING ITS OWN UNIQUE "COMMON NAME",
# UNCOMMENT THIS LINE OUT.
#;duplicate-cn

# The keepalive directive causes ping-like
# messages to be sent back and forth over
# the link so that each side knows when
# the other side has gone down.
# Ping every 10 seconds, assume that remote
# peer is down if no ping received during
# a 120 second time period.
#keepalive 10 120
keepalive #{keepalive}  ### GENERATED

# For extra security beyond that provided
# by SSL/TLS, create an "HMAC firewall"
# to help block DoS attacks and UDP port flooding.
#
# Generate with:
#   openvpn --genkey --secret ta.key
#
# The server and each client must have
# a copy of this key.
# The second parameter should be '0'
# on the server and '1' on the clients.
#;tls-auth ta.key 0 # This file is secret
tls-auth #{key_dir}/ta.key 0  ### GENERATED

# Select a cryptographic cipher.
# This config item must be copied to
# the client config file as well.
# ;cipher BF-CBC        # Blowfish (default)
# ;cipher AES-128-CBC   # AES
# ;cipher DES-EDE3-CBC  # Triple-DES
cipher #{cipher} ### GENERATED

# Enable compression on the VPN link.
# If you enable it here, you must also
# enable it in the client config file.
# comp-lzo
#{"comp-lzo  ### GENERATED" if comp_lzo}

# The maximum number of concurrently connected
# clients we want to allow.
# ;max-clients 100
max-clients #{max_clients} ### GENERATED

# It's a good idea to reduce the OpenVPN
# daemon's privileges after initialization.
#
# You can uncomment this out on
# non-Windows systems.
# ;user nobody
# ;group nobody

# The persist options will try to avoid
# accessing certain resources on restart
# that may no longer be accessible because
# of the privilege downgrade.
persist-key
persist-tun

# Output a short status file showing
# current connections, truncated
# and rewritten every minute.
# status openvpn-status.log
status #{status_file} ### GENERATED

# By default, log messages will go to the syslog (or
# on Windows, if running as a service, they will go to
# the "\Program Files\OpenVPN\log" directory).
# Use log or log-append to override this default.
# "log" will truncate the log file on OpenVPN startup,
# while "log-append" will append to it.  Use one
# or the other (but not both).
# ;log         openvpn.log
# ;log-append  openvpn.log
log-append #{log_file} ### GENERATED

# Set the appropriate level of log
# file verbosity.
#
# 0 is silent, except for fatal errors
# 4 is reasonable for general usage
# 5 and 6 can help to debug connection problems
# 9 is extremely verbose
# verb 3
verb #{verbosity} ### GENERATED

# Silence repeating messages.  At most 20
# sequential messages of the same message
# category will be output to the log.
# ;mute 20

EOF
  end
  
end