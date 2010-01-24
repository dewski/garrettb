directory "/Users/garrett/src/sites/GB", :glob => "{*/,}*.gemspec"

only :development do
   gem "paperclip", :path => "/Users/garrett/src/paperclip"
end

only :production do
   gem "paperclip", :git => "git://github.com/dewski/paperclip.git", :branch => "rails3"
end

git "git://github.com/rails/arel.git"
git "git://github.com/rails/rack.git"

gem "rails", :git => "git://github.com/rails/rails.git"
gem "authlogic", :git => "git://github.com/binarylogic/authlogic.git"