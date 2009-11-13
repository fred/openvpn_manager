class InstalledClient
  
  attr_accessor :vpn_crt, :vpn_csr, :vpn_key, :vpn_ip, :name, :vpn_crt_file, :vpn_csr_file, :vpn_key_file
  
  FETCH_FOLDER = "/Users/fred/Servers/fredz2/etc/openvpn/privnet"
  
  # VPN user name
  def name
    @name
  end
  def vpn_name=(vpn_name)
    @name = vpn_name
  end
  
  # VPN user IP
  def vpn_ip
    @vpn_ip
  end
  def vpn_ip=(vpn_ip)
    @vpn_ip = vpn_ip
  end
  
  # VPN .key file content
  def vpn_key
    @vpn_key
  end
  def vpn_key=(vpn_key)
    @vpn_key = vpn_key
  end
  
  # VPN .csr file content
  def vpn_csr
    @vpn_csr
  end
  def vpn_csr=(vpn_csr)
    @vpn_csr = vpn_csr
  end

  # VPN .crt file content
  def vpn_crt_file
    @vpn_crt_file
  end
  def vpn_crt_file=(vpn_crt_file)
    @vpn_crt_file = vpn_crt_file
  end
  
  # VPN .key file content
  def vpn_key_file
    @vpn_key_file
  end
  def vpn_key_file=(vpn_key_file)
    @vpn_key_file = vpn_key_file
  end
  
  # VPN .csr file content
  def vpn_csr_file
    @vpn_csr_file
  end
  def vpn_csr_file=(vpn_csr_file)
    @vpn_csr_file = vpn_csr_file
  end

  # VPN .crt file content
  def vpn_crt_file
    @vpn_crt_file
  end
  def vpn_crt_file=(vpn_crt_file)
    @vpn_crt_file = vpn_crt_file
  end
  
  # VPN .crt file content
  def errors
    @errors
  end
  def errors=(errors)
    @errors = errors
  end
  
  
  def self.all
    # only clients have a .csr file
    keys = Dir.glob("#{InstalledClient::FETCH_FOLDER}/*.csr")
    users = keys.map {|t| t.split("/").last.gsub(".csr","")}
    installed_clients = []
    users.each do |t| 
      record = InstalledClient.find(t)
      installed_clients << record
    end
    installed_clients
  end
  
  def self.find(name)
    keys = Dir.glob("#{InstalledClient::FETCH_FOLDER}/#{name}.crt")
    if keys.empty?
      return nil
    else
      name = keys[0].split("/").last.gsub(".crt","")
      record = InstalledClient.new
      record.name = name.to_s
      record.vpn_key_file  = "#{FETCH_FOLDER}/#{name}.key"
      record.vpn_crt_file  = "#{FETCH_FOLDER}/#{name}.crt"
      record.vpn_csr_file  = "#{FETCH_FOLDER}/#{name}.csr"
      record.vpn_key  = File.read("#{FETCH_FOLDER}/#{name}.key") if File.exist?(record.vpn_key_file)
      record.vpn_crt  = File.read("#{FETCH_FOLDER}/#{name}.crt") if File.exist?(record.vpn_crt_file)
      record.vpn_csr  = File.read("#{FETCH_FOLDER}/#{name}.csr") if File.exist?(record.vpn_csr_file)
      record
    end
  end
  
  def save
    if find(self.name)
      self.errors = {:name => "name is already used"}
      raise "Name already exists"
    else
      true
      # generate keys command
    end
  end
  
  # Revoke user certificates
  # read: http://openvpn.net/index.php/open-source/documentation/howto.html#revoke
  def destroy
    # FileUtils.rm_rf(self.vpn_csr_file) if File.exist?(self.vpn_csr_file)
    # FileUtils.rm_rf(self.vpn_key_file) if File.exist?(self.vpn_key_file)
    # FileUtils.rm_rf(self.vpn_crt_file) if File.exist?(self.vpn_crt_file)
    # revoke command
  end
  
end
