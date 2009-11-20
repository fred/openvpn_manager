# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

Setting.create(
  [
    { :var => "port", 
      :value => "1194", 
      :description => "
      # Which TCP/UDP port should OpenVPN listen on?
      # If you want to run multiple OpenVPN instances
      # on the same machine, use a different port
      # number for each one.  You will need to
      # open up this port on your firewall.
      Default: 1194"},
    
    { :var => "protocol", 
      :value => "udp", 
      :description => "
      TCP or UDP server?
      UDP protocol is slightly faster than TCP.
      Default: udp"},
      
    { :var => "interface_device", 
      :value => "tun", 
      :description => "
      # Will create a routed IP tunnel,
      # 'dev tap' will create an ethernet tunnel.
      # Use 'dev tap0' if you are ethernet bridging
      # and have precreated a tap0 virtual interface
      # and bridged it with your ethernet interface.
      # If you want to control access policies
      # over the VPN, you must create firewall
      # rules for the the TUN/TAP interface.
      # On non-Windows systems, you can give
      # an explicit unit number, such as tun0.
      # On Windows, use 'dev-node' for this.
      # On most systems, the VPN will not function
      # unless you partially or fully disable
      # the firewall for the TUN/TAP interface.
      Default: tun"},
    
    { :var => "server_network", 
      :value => "10.8.0.0 255.255.255.0", 
      :description => "
      # Configure server mode and supply a VPN subnet
      # for OpenVPN to draw client addresses from.
      # The server will take 10.8.0.1 for itself,
      # the rest will be made available to clients.
      # Each client will be able to reach the server
      # on 10.8.0.1. Comment this line out if you are
      # ethernet bridging. See the man page for more info.
      Default: 10.8.0.0 255.255.255.0"},
      
    { :var => "server_ip", 
      :value => "10.8.0.1 10.8.0.2", 
      :description => "
      IP to be set for server itself.
      Default: 10.8.0.1 10.8.0.2"},

    { :var => "ccd", 
      :value => "/etc/openvpn/ccd", 
      :description => "
      Client Config Dir, for client-specific configuration files.
      Default: /etc/openvpn/ccd"},

    { :var => "redirect_gateway", 
      :value => "1",
      :description => "
      Redirect all traffic from clients to server.
      you need run Nat and ip_forwarding on server
      Default: 1"},
      
    { :var => "keepalive", 
      :value => "10 120", 
      :description => "
      # The keepalive directive causes ping-like
      # messages to be sent back and forth over
      # the link so that each side knows when
      # the other side has gone down.
      # Ping every 10 seconds, assume that remote
      # peer is down if no ping received during
      # a 120 second time period.
      Default: 10 120"},
      
    { :var => "cipher", 
      :value => "BF-CBC", 
      :description => "
      # Select a cryptographic cipher.
      # This config item must be copied to
      # the client config file as well.
      ;cipher BF-CBC        # Blowfish (default)
      ;cipher AES-128-CBC   # AES
      ;cipher DES-EDE3-CBC  # Triple-DES
      Default: BF-CBC"},
      
    { :var => "comp_lzo", 
      :value => "1", 
      :description => "
      Compress data using LZO high compression algorithm.
      Default: 1 (yes)"},
      
    { :var => "max_clients", 
      :value => "100", 
      :description => "
      # The maximum number of concurrently connected
      # clients we want to allow.
      Default: 100"},
    
    { :var => "verbosity", 
      :value => "4",
      :description => "
      # Set the appropriate level of log
      # file verbosity.
      #
      # 0 is silent, except for fatal errors
      # 4 is reasonable for general usage
      # 5 and 6 can help to debug connection problems
      # 9 is extremely verbose
      Default: 4"},
    
    { :var => "client_to_client", 
      :value => "1", 
      :description => "
      # Allow different clients to be able to see each other.
      # By default, clients will only see the server.
      # To force clients to only see the server, you
      # will also need to appropriately firewall the
      # server's TUN/TAP interface.
      Default: 1 (yes)"},
    
    { :var => "STATUS_LOG", 
      :value => "/var/log/openvpn/openvpn-status.log", 
      :description => "
        File that shows a short status, current connections, 
        truncated and rewritten every minute, 
        bytes sent and received by each user. 
        Default: /var/log/openvpn/openvpn-status.log"},
      
    { :var => "EASY_RSA", 
      :value => "/etc/openvpn/easy-rsa", 
      :description => "NOTE: If you installed from an RPM, don't edit this file in place in /usr/share/openvpn/easy-rsa  
        instead, you should copy the whole easy-rsa directory to another location (such as /etc/openvpn) 
        so that your edits will not be wiped out by a future OpenVPN package upgrade. 
        This variable should point to the top level of the easy-rsa tree."},
    
    { :var => "OPENSSL", 
      :value => "openssl", 
      :description => "This variable should point to the requested executables"},  
      
    { :var => "PKCS11TOOL", 
      :value => "pkcs11-tool", 
      :description => "This variable should point to the requested executables"},
      
    { :var => "GREP", 
      :value => "grep", 
      :description => "This variable should point to the requested executables"},
      
    { :var => "KEY_CONFIG", 
      :value => "/etc/openvpn/easy-rsa/openssl.cnf",
      :description => "# This variable should point to the openssl.cnf file included with easy-rsa.
      Default: /etc/openvpn/easy-rsa/openssl.cnf "},
      
    { :var => "KEY_DIR", 
      :value => "/etc/openvpn/privnet", 
      :description => "Edit this variable to point to your keys directory."},
      
    { :var => "KEY_DIR_BAK", 
      :value => "/etc/openvpn/privnet.bak", 
      :description => "Edit this variable to point to your keys backup directory."},  
      
    { :var => "PKCS11_MODULE_PATH", 
      :value => "dummy", 
      :description => "# PKCS11 fixes"},
      
    { :var => "PKCS11_PIN", 
      :value => "dummy", 
      :description => "PKCS11 fixes"},
      
    { :var => "KEY_SIZE", 
      :value => "1024", 
      :description => "Increase this to 2048 if you are paranoid.  
        This will slow down TLS negotiation performance as well as the one-time DH parms generation process."},
    
    { :var => "CA_EXPIRE", 
      :value => "9600", 
      :description => "In how many days should the root CA key expire?"},

    { :var => "KEY_EXPIRE", 
      :value => "9600", 
      :description => "In how many days should certificates expire?"},
    
    { :var => "KEY_COUNTRY", 
      :value => "US", 
      :description => "These are the default values for fields which will be placed in the certificate. 
        Don't leave any of these fields blank."},
      
    { :var => "KEY_PROVINCE", 
      :value => "CD", 
      :description => "These are the default values for fields which will be placed in the certificate. 
        Don't leave any of these fields blank."},
  
    { :var => "KEY_CITY", 
      :value => "SanJose", 
      :description => "These are the default values for fields which will be placed in the certificate. 
        Don't leave any of these fields blank."},
  
    { :var => "KEY_ORG", 
      :value => "mathaba.net", 
      :description => "These are the default values for fields which will be placed in the certificate. 
      Don't leave any of these fields blank."},
  
    { :var => "KEY_EMAIL", 
      :value => "vpn@mathaba.net", 
      :description => "These are the default values for fields which will be placed in the certificate. 
        Don't leave any of these fields blank."},
    
    { :var => "IPP_FILE", 
      :value => "/etc/openvpn/ipp.txt", 
      :description => "
        ipp.txt is the file that contains records of client IPs. 
        # Maintain a record of client <-> virtual IP address
        # associations in this file.  If OpenVPN goes down or
        # is restarted, reconnecting clients can be assigned
        # the same virtual IP address from the pool that was
        # previously assigned.
        Default: /etc/openvpn/ipp.txt"},
    
    { :var => "LOG_FILE", 
      :value => "/var/log/openvpn/openvpn.log", 
      :description => "Log file of openvpn. Default: /var/log/openvpn/openvpn.log"},
      
    { :var => "CONFIG_FILE", 
      :value => "/etc/openvpn/openvpn.conf", 
      :description => "Main Config file of openvpn. Default: /etc/openvpn/openvpn.conf"},
      
    { :var => "PID_FILE", 
      :value => "/var/run/openvpn.pid", 
      :description => "PID file of openvpn, to check if it's running. Default: /var/run/openvpn.pid"},
      
    { :var => "START_COMMAND", 
      :value => "/etc/init.d/openvpn start", 
      :description => "Command to Start OpenVPN. Default: /etc/init.d/openvpn start"},
  
    { :var => "STOP_COMMAND", 
      :value => "/etc/init.d/openvpn stop", 
      :description => "Command to Stop OpenVPN. Default: /etc/init.d/openvpn stop"},

    { :var => "RESTART_COMMAND", 
      :value => "/etc/init.d/openvpn restart", 
      :description => "Command to Restart OpenVPN. Default: /etc/init.d/openvpn restart"},
      
    { :var => "HTTPS_ONLY", 
      :value => 0, 
      :description => "Set 1, if you prefer to use HTTPS only", 
      :vpn_only => false},
    
    { :var => "STATUS_LOG", 
      :value => "/var/log/openvpn/openvpn-status.log", 
      :description => "File that shows a short status, current connections, 
        truncated and rewritten every minute, 
        bytes sent and received by each user. 
        Default: /var/log/openvpn/openvpn-status.log"},
  ]  
)

User.create(:name => "admin", 
  :email => "admin@localhost.com", 
  :password => "welcome", 
  :password_confirmation => "welcome" 
)

