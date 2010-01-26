require File.expand_path('../boot', __FILE__)

module GB
  class Application < Rails::Application
    config.time_zone = 'Pacific Time (US & Canada)'
    
    config.filter_parameters = :password
    
    
    config.generators do |g|
      g.orm             :active_record
      g.template_engine :haml
      g.test_framework  :test_unit, :fixture => true
    end
  end
end