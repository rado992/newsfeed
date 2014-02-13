# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
require 'securerandom'

def secure_token
  token_file = Rails.root.join('.secret')
  if File.exist?(token_file)
    # Use the existing token.
    File.read(token_file).chomp
  else
    # Generate a new token and store it in token_file.
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end
end

Newsfeed::Application.config.secret_token = secure_token

# Newsfeed::Application.config.secret_token = '8f3d60462cb4109f93e2fac7df477a6ea2ce6e36856eb315d5fb3f72d93ef90b1e37f2ed49fb9ee86db13b780e092db0b2081157260f814e5faac51e19917594'
