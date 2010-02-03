set :rails_env, "production"
set :deploy_to, "/var/www/garrettb/#{rails_env}"

namespace :deploy do
  task :move_in_database_yml, :roles => :app do
    run "cp /var/www/garrettb/#{rails_env}/shared/system/database.yml #{current_path}/config/"
  end
  
  task :move_in_asset_info, :roles => :app do
    run "cp /var/www/garrettb/#{rails_env}/shared/system/s3.yml #{current_path}/config/"
    run "cp /var/www/garrettb/#{rails_env}/shared/system/synch_s3_asset_host.yml #{current_path}/config/"
  end
end