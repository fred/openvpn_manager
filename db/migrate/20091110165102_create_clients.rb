class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string  :name
      t.string  :email
      t.string  :vpn_ip
      t.text    :vpn_crt
      t.text    :vpn_key
      t.text    :vpn_csr
      t.text    :vpn_rvk
      t.text    :notes 
      t.timestamps
      t.datetime :expires_at
      t.datetime :sent_files_at
    end
    
    add_index :clients, :name, :unique => true
    add_index :clients, :email, :unique => false
    add_index :clients, :expires_at, :unique => false
  end

  def self.down
    drop_table :clients
  end
end
