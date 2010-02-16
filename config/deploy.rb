set :default_stage, 'staging'
set :stages, %w(staging production)
require 'capistrano/ext/multistage'

default_run_options[:pty] = true

set :application, "garrettb"

set :scm, :git
set :deploy_via, :remote_cache
set :repository,  "git@github.com:dewski/garrettb.git"
set :branch, "master"

set :user, "deploy"
set :ssh_options, { :forward_agent => true }

role :web, "garrettbjerkhoel.com", :asset_host_syncher => true
role :app, "garrettbjerkhoel.com"
role :db, "garrettbjerkhoel.com", :primary => true

namespace :deploy do
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path, "tmp", "restart.txt")}"
  end
  
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end

namespace :maintenance do
  desc "This will disable the application and show a warning screen"
  task :on do
    run "haml #{current_path}/app/views/layouts/maintenance.html.haml #{current_path}/public/system/maintenance.html"
  end
  
  desc "This will enable the application and remove the warning screen"
  task :off do
    run "rm #{current_path}/public/system/maintenance.html"
  end
end

namespace :bundler do
  task :install do
    run("#{try_sudo} gem install bundler --source=http://gemcutter.org")
  end
  
  task :install do
    run "cd #{release_path} && bundle install --without test"
  end
end

#######
# Tasks
########################
# Migrate the DB
before "deploy:symlink", "deploy:move_in_asset_info", "deploy:move_in_database_yml"
after "deploy", "deploy:migrate", "deploy:cleanup"
after "deploy:update_code", "bundler:install"