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
    t.string   "login",                                  :null => false
    t.string   "email",                                  :null => false
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.string   "persistence_token",                      :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "address"
    t.string   "phone"
    t.string   "name"
    t.string   "time_zone"
    t.text     "notes"
    t.boolean  "admin",               :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
