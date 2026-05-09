# config/initializers/omniauth.rb
OmniAuth.config.allowed_request_methods = [:get, :post]
OmniAuth.config.silence_get_warning = true
OmniAuth.config.full_host = "http://localhost:3000"
