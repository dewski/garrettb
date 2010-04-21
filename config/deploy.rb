set :default_stage, 'staging'
set :stages, %w(staging production)
require 'capistrano/ext/multistage'

default_run_options[:pty] = true

set :application, 'garrettb'
set :deploy_to, '/var/www/garrettb'

# Git options
set :scm, :git
set :repository, 'git@github.com:dewski/garrettb.git'
set :branch, 'origin/master'

set :user, 'deploy'
set :ssh_options, { :forward_agent => true }

role :web, 'garrettbjerkhoel.com'
role :app, 'garrettbjerkhoel.com'
role :db,  'garrettbjerkhoel.com', :primary => true

namespace :deploy do
  desc "Deploy app"
  task :default do
    update
    restart
  end
  
  desc "Update code, bundle all assets, migrate db, install gems"
  task :full do
    update
    migrate
    bundle
    restart
    cleanup
  end
 
  desc "Setup a GitHub-style deployment."
  task :setup, :except => { :no_release => true } do
    run "git clone #{repository} #{current_path}"
  end
 
  desc "Update the deployed code."
  task :update_code, :except => { :no_release => true } do
    run "cd #{current_path}; git fetch origin; git reset --hard #{branch}"
  end

  desc "Deploy and run migrations"
  task :migrations, :except => { :no_release => true } do
    update
    migrate
    restart
    cleanup
  end

  desc "Run pending migrations on already deployed code"
  task :migrate, :except => { :no_release => true } do
    run "cd #{current_path}; rake RAILS_ENV=#{rails_env} db:migrate"
  end
 
  namespace :rollback do
    desc "Rollback a single commit."
    task :code, :except => { :no_release => true } do
      set :branch, "HEAD^"
      deploy.default
    end

    task :default do
      rollback.code
    end
  end
    
  desc "Make all the symlinks"
  task :symlink, :roles => :app, :except => { :no_release => true } do
    set :normal_symlinks, %w(
      tmp/pids
      config/database.yml
      config/s3.yml
      log/staging.log
      log/production.log
    )
    
    set :weird_symlinks, {
      'pids' => 'tmp/pids'
    }
    
    commands = normal_symlinks.map do |path|
      "rm -rf #{current_path}/#{path} && \
       ln -s #{shared_path}/#{path} #{current_path}/#{path}"
    end

    commands += weird_symlinks.map do |from, to|
      "rm -rf #{current_path}/#{to} && \
       ln -s #{shared_path}/#{from} #{current_path}/#{to}"
    end

    run "mkdir -p #{current_path}/tmp && \
         mkdir -p #{current_path}/public/system && \
         mkdir -p #{current_path}/config && \
         mkdir -p #{current_path}/log"
         
    run <<-CMD
      cd #{current_path} &&
      #{commands.join(' && ')}
    CMD
  end
  
  # override default tasks to make capistrano happy
  desc "Kick Passenger"
  task :start do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Kick Passenger"
  task :restart do
    stop
    start
  end

  desc "Kick Passenger"
  task :stop do
  end
  
  desc "Install all gems"
  task :bundle do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle install --without development test &>2"
  end
end