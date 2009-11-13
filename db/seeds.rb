# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

Setting.create(
  [
    { :var => "EASY_RSA", 
      :value => "/etc/openvpn/easyrsa", 
      :description => "NOTE: If you installed from an RPM, don't edit this file in place in /usr/share/openvpn/easy-rsa -- instead, you should copy the whole easy-rsa directory to another location (such as /etc/openvpn) so that your edits will not be wiped out by a future OpenVPN package upgrade. This variable should point to the top level of the easy-rsa tree.", 
      :vpn_only => true},
    
    { :var => "OPENSSL", 
      :value => "openssl", 
      :description => "This variable should point to the requested executables", 
      :vpn_only => true},  
      
    { :var => "PKCS11TOOL", 
      :value => "pkcs11-tool", 
      :description => "This variable should point to the requested executables", 
      :vpn_only => true},
      
    { :var => "GREP", 
      :value => "grep", 
      :description => "This variable should point to the requested executables", 
      :vpn_only => true},
      
    { :var => "KEY_CONFIG", 
      :value => "/etc/openvpn/easyrsa/whichopensslcnf /etc/openvpn/easyrsa", 
      :description => "# This variable should point to the openssl.cnf file included with easy-rsa.", 
      :vpn_only => true},
      
    { :var => "KEY_DIR", 
      :value => "/etc/openvpn/privnet", 
      :description => "Edit this variable to point to your keys directory.", 
      :vpn_only => true},
      
    { :var => "KEY_DIR_BAK", 
      :value => "/etc/openvpn/privnet.bak", 
      :description => "Edit this variable to point to your keys backup directory.", 
      :vpn_only => true},  
      
    { :var => "PKCS11_MODULE_PATH", 
      :value => "dummy", 
      :description => "# PKCS11 fixes", 
      :vpn_only => true},
      
    { :var => "PKCS11_PIN", 
      :value => "dummy", 
      :description => "PKCS11 fixes", 
      :vpn_only => true},
      
    { :var => "KEY_SIZE", 
      :value => "1024", 
      :description => "Increase this to 2048 if you are paranoid.  This will slow down TLS negotiation performance as well as the one-time DH parms generation process.", 
      :vpn_only => true},
    
    { :var => "CA_EXPIRE", 
      :value => "9600", 
      :description => "In how many days should the root CA key expire?", 
      :vpn_only => true},

    { :var => "KEY_EXPIRE", 
      :value => "9600", 
      :description => "In how many days should certificates expire?", 
      :vpn_only => true},
    
    { :var => "KEY_COUNTRY", 
      :value => "US", 
      :description => "These are the default values for fields which will be placed in the certificate. Don't leave any of these fields blank.", 
      :vpn_only => true},
      
    { :var => "KEY_PROVINCE", 
      :value => "CD", 
      :description => "These are the default values for fields which will be placed in the certificate. Don't leave any of these fields blank.", 
      :vpn_only => true},
  
    { :var => "KEY_CITY", 
      :value => "SanJose", 
      :description => "These are the default values for fields which will be placed in the certificate. Don't leave any of these fields blank.", 
      :vpn_only => true},
  
    { :var => "KEY_ORG", 
      :value => "mathaba.net", 
      :description => "These are the default values for fields which will be placed in the certificate. Don't leave any of these fields blank.", 
      :vpn_only => true},
  
    { :var => "KEY_EMAIL", 
      :value => "vpn@mathaba.net", 
      :description => "These are the default values for fields which will be placed in the certificate. Don't leave any of these fields blank.", 
      :vpn_only => true},
    
    { :var => "IPP_FILE", 
      :value => "/etc/openvpn/ipp.txt", 
      :description => "ipp.txt is the file that contains records of client IPs. Default: /etc/openvpn/ipp.txt", 
      :vpn_only => true},
    
    { :var => "LOG_FILE", 
      :value => "/var/log/openvpn/openvpn.log", 
      :description => "Log file of openvpn. Default: /var/log/openvpn/openvpn.log", 
      :vpn_only => true},
      
    { :var => "CONFIG_FILE", 
      :value => "/etc/openvpn/openvpn.conf", 
      :description => "Main Config file of openvpn. Default: /etc/openvpn/openvpn.conf", 
      :vpn_only => true},
      
    { :var => "PID_FILE", 
      :value => "/var/run/openvpn.pid", 
      :description => "PID file of openvpn, to check if it's running. Default: /var/run/openvpn.pid", 
      :vpn_only => true},
      
    { :var => "START_COMMAND", 
      :value => "/etc/init.d/openvpn start", 
      :description => "Command to Start OpenVPN. Default: /etc/init.d/openvpn start", 
      :vpn_only => true},
  
    { :var => "STOP_COMMAND", 
      :value => "/etc/init.d/openvpn stop", 
      :description => "Command to Stop OpenVPN. Default: /etc/init.d/openvpn stop", 
      :vpn_only => true},
  ]
  
)
