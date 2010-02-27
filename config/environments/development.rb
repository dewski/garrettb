GB::Application.configure do
  config.cache_classes = false
  # ABQIAAAA8IIQcuiiU7QFPjD0KiH_PhSzY5icoUoR77ZPl8RXejMU8oPzzRT7qmrsMqWBpVudpqQ6l4uZOf7Lvg
  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local                   = true
  config.action_view.debug_rjs                         = true
  config.action_controller.perform_caching             = false
  config.cache_store = :mem_cache_store
  
  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address => "localhost",
    :port => 1025,
    :domain => "www.garrettbjerkhoel.com"
  }
  
  Paperclip.options[:command_path] = "/usr/local/bin"
end