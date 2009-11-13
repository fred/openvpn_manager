# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_openvpn_session',
  :secret      => 'ed2821d22da5ba8468473c45b744a8fa4b907eb58e8a265ad30efe8189dc299c3917deec621f44febd6d4d51ec2bc0d2bdeb8d7aa47233cf527b839ce14fe5a9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
