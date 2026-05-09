Devise.setup do |config|
  config.mailer_sender = 'no-reply@example.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 12

  config.reconfirmable = false
  config.password_length = 6..128

  # Google OAuth
  config.omniauth_path_prefix = '/users/auth'
end
