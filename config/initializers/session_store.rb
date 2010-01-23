# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_GB_session',
  :secret => '7e8313ff94b8fcb77452a71f9e8c63ea2967e1d98d329b113d78f71b196cb1b1789eb64f8870a3783bcbfffef4f5057e4eec238a0b2453a365d2631a658051b7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
