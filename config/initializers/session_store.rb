# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_constantwin_session',
  :secret      => '154dd65df2d325149745ba3c3a576ccfe528260f09fba4454b8c022631df8aab05b06cf082c8950ddb5c3dd48b343f68998d0da55490fd75bb8ca8faeb709c2b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
