GB::Application.configure do
  config.cache_classes = true

  config.action_controller.consider_all_requests_local = false
  config.action_controller.perform_caching             = true

  # Use a different cache store in production
  config.cache_store = :mem_cache_store, "172.19.2.187:11211"
  config.serve_static_assets = false
  config.action_controller.asset_host = "http://img.garrettbjerkhoel.com"
  
  Paperclip.options[:command_path] = "/usr/local/bin"
  Paperclip.options[:log_command] = true
end