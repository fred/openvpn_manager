class Client < ActiveRecord::Base
  
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_size_of :name, :within => 4..20
  
  BACKUP_FOLDER = "/Users/fred/Servers/fredz2/etc/openvpn/privnet"
  
  #before_create :generate_keys
  
  
  def self.migrate_from_system
    a = 0
    InstalledClient.all.each do |ic|
      if client = self.find(:first, :conditions => ["name = ?", ic.name])
        client.update_attributes(
          :name => ic.name, :vpn_crt => ic.vpn_crt, 
          :vpn_csr => ic.vpn_csr,:vpn_key => ic.vpn_key
        )
      else
        client = Client.new(
          :name => ic.name, :vpn_crt => ic.vpn_crt, 
          :vpn_csr => ic.vpn_csr,:vpn_key => ic.vpn_key
        )
        if client.valid?
          a += 1
          client.save
        end
      end
    end
    a
  end
  
  
  def generate_files
  end
  
  def revoke
  end
  
  def get_ip
  end
    
end
