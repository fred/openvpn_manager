class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.string  :var
      t.text    :value
      t.text    :description
      t.boolean :vpn_only, :default => false
      t.timestamps
    end
    add_index :settings, :var,      :unique => true
    add_index :settings, :vpn_only, :unique => false
  end

  def self.down
    drop_table :settings
  end
end
