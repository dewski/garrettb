# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_GB_session',
  :secret => '90bec447368ddfa2b54c37fbebddf506cc544580caeb9462b997a93ea5d82938478b8958e1fd5bfe3b21a85b20ee2d008d598de191631e8f09a966e99aadb1b4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
