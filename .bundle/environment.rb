# DO NOT MODIFY THIS FILE
module Bundler
  LOAD_PATHS = ["/Library/Ruby/Gems/1.8/gems/builder-2.1.2/lib", "/Library/Ruby/Gems/1.8/gems/text-hyphen-1.0.0/lib", "/Library/Ruby/Gems/1.8/gems/i18n-0.3.3/lib", "/Library/Ruby/Gems/1.8/gems/bundler-0.9.5/lib", "/Library/Ruby/Gems/1.8/gems/arel-0.2.1/lib", "/Library/Ruby/Gems/1.8/gems/activemodel-3.0.0.beta/lib", "/Users/garrett/.bundle/gems/rack-mount-0.4.7/lib", "/Library/Ruby/Gems/1.8/gems/mime-types-1.16/lib", "/Library/Ruby/Gems/1.8/gems/mail-2.1.2/lib", "/Library/Ruby/Gems/1.8/gems/abstract-1.0.0/lib", "/Library/Ruby/Gems/1.8/gems/erubis-2.6.5/lib", "/Users/garrett/.bundle/gems/thor-0.13.1/lib", "/Library/Ruby/Gems/1.8/gems/rake-0.8.7/lib", "/Library/Ruby/Gems/1.8/gems/railties-3.0.0.beta/lib", "/Library/Ruby/Gems/1.8/gems/memcache-client-1.7.8/lib", "/Library/Ruby/Gems/1.8/gems/rack-1.1.0/lib", "/Library/Ruby/Gems/1.8/gems/rack-test-0.5.3/lib", "/Library/Ruby/Gems/1.8/gems/actionpack-3.0.0.beta/lib", "/Library/Ruby/Gems/1.8/gems/bluecloth-2.0.7/lib", "/Library/Ruby/Gems/1.8/gems/bluecloth-2.0.7/ext", "/Users/garrett/.bundle/bundler/gems/authlogic-616f4e3cab847292be895b9e8ff207d9be1926ab-85b2a6b3e9993b18c7fb1e4f7b9c6d01cc8b5d17/lib", "/Library/Ruby/Gems/1.8/gems/text-format-1.0.0/lib", "/Library/Ruby/Gems/1.8/gems/actionmailer-3.0.0.beta/lib", "/Library/Ruby/Gems/1.8/gems/activerecord-3.0.0.beta/lib", "/Users/garrett/.bundle/bundler/gems/paperclip-84bceb6ee68898199063a4580bf19571f338c972-b7bc4c6f9d155ce1cc278730d10e65868ccd70c8/lib", "/Library/Ruby/Gems/1.8/gems/tzinfo-0.3.16/lib", "/Library/Ruby/Gems/1.8/gems/activesupport-3.0.0.beta/lib", "/Library/Ruby/Gems/1.8/gems/activeresource-3.0.0.beta/lib", "/Library/Ruby/Gems/1.8/gems/rails-3.0.0.beta/"]
  AUTOREQUIRES = {:default=>["rails", "authlogic", "paperclip", "bluecloth"]}

  def self.setup(*groups)
    LOAD_PATHS.each { |path| $LOAD_PATH.unshift path }
  end

  def self.require(*groups)
    groups = [:default] if groups.empty?
    groups.each do |group|
      AUTOREQUIRES[group].each { |file| Kernel.require file }
    end
  end

  # Setup bundle when it's required.
  setup
end
