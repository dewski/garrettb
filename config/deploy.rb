default_run_options[:pty] = true

set :application, "garrettb"
set :deploy_to, "/var/www/garrettb"

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
  
  desc "Run gem bundle"
  task :bundle, :roles => :db do
    run "cd #{current_path} && gem bundle"
  end
  
  task :move_in_database_yml, :roles => :app do
    run "cp #{deploy_to}/shared/system/database.yml #{current_path}/config/"
  end
  
  task :move_in_asset_info, :roles => :app do
    run "cp #{deploy_to}/shared/system/synch_s3_asset_host.yml #{current_path}/config/"
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

  task :symlink_vendor do
    shared_gems = File.join(shared_path, "vendor/gems")
    release_gems = "#{release_path}/vendor/gems" 
    %w(cache gems specifications).each do |sub_dir|
      shared_sub_dir = File.join(shared_gems, sub_dir)
      run("mkdir -p #{shared_sub_dir} && mkdir -p #{release_gems} && ln -s #{shared_sub_dir} #{release_gems}/#{sub_dir}")
    end
  end

  task :bundle_new_release do
    bundler.symlink_vendor
    run("cd #{release_path} && gem bundle --only #{rails_env}")
  end
end

#######
# Tasks
########################
# Migrate the DB
after "deploy", "deploy:migrate", "deploy:cleanup"
after "deploy:symlink", "deploy:move_in_asset_info", "s3_asset_host:synch_public", "deploy:move_in_database_yml", "deploy:bundle"
after "deploy:update_code", "bundler:bundle_new_release"