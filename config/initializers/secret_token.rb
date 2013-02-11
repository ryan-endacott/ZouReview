# Be sure to restart your server when you modify this file.

if Rails.env.production? && ENV['SECRET_TOKEN'].blank?
  raise 'SECRET_TOKEN environment variable must be set!'
end

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Mizzouclass::Application.config.secret_token = 
  ENV['SECRET_TOKEN'] || dceba89e94d58923984d01ea727584f25aee64f85c39ff3a069e25b16b086a6057c061a15915eafb4dcf4abeb4e5bd336453aef88907d7bddd4259b2e489dd94'
