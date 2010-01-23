# Use Bundler (preferred)
environment = File.expand_path('../../vendor/gems/environment', __FILE__)
if File.exist?("#{environment}.rb")
  require environment
else
  vendor_rails = File.expand_path('../../vendor/rails', __FILE__)
  if File.exist?(vendor_rails)
    Dir["#{vendor_rails}/*/lib"].each { |path| $:.unshift(path) }
  end

  require 'rubygems'
end

require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "action_mailer/railtie"

require "paperclip"
require "authlogic"