# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091111191138) do

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "vpn_ip"
    t.text     "vpn_crt"
    t.text     "vpn_key"
    t.text     "vpn_csr"
    t.text     "vpn_rvk"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "expires_at"
    t.datetime "sent_files_at"
  end

  add_index "clients", ["email"], :name => "index_clients_on_email"
  add_index "clients", ["expires_at"], :name => "index_clients_on_expires_at"
  add_index "clients", ["name"], :name => "index_clients_on_name", :unique => true

  create_table "settings", :force => true do |t|
    t.string   "var"
    t.text     "value"
    t.text     "description"
    t.boolean  "vpn_only",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["var"], :name => "index_settings_on_var", :unique => true
  add_index "settings", ["vpn_only"], :name => "index_settings_on_vpn_only"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password", :limit => 128
    t.string   "salt",               :limit => 128
    t.string   "confirmation_token", :limit => 128
    t.string   "remember_token",     :limit => 128
    t.boolean  "email_confirmed",                   :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["id", "confirmation_token"], :name => "index_users_on_id_and_confirmation_token"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
