GB::Application.configure do
  config.cache_classes = true
  config.consider_all_requests_local                   = false
  config.action_controller.perform_caching             = true

  # Use a different cache store in production
  config.cache_store = :mem_cache_store, "172.19.2.187:11211"
  config.serve_static_assets = false
  config.action_controller.asset_host = "http://img.garrettbjerkhoel.com"
  
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address => "smtp.sendgrid.net",
    :port => '25',
    :domain => "clientend.com",
    :authentication => :plain,
    :user_name => "admin@clientend.com",
    :password => "dewski"
  }
  
  Paperclip.options[:command_path] = "/usr/local/bin"
end

GOOGLE_MAPS_API_KEY = 'ABQIAAAA8IIQcuiiU7QFPjD0KiH_PhRfGsGpnvwevLrP5n73-Kc7CSiPJxQVOJFFGVmJLa6tw5meJc_fVJobpQ'