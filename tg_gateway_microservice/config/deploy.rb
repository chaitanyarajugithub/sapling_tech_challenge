# config valid for current version and patch releases of Capistrano

# set :application, "my_app_name"
# set :repo_url, "git@example.com:me/my_repo.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure


# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"
set :default_shell, "/bin/bash -l"
set :rvm_ruby_version, '2.5.1'
set :default_stage, "production"
set :application, "tg_gateway_microservice"
set :user, "sandeep"
set :repo_url,  "git@github.com:saplingapp/demo-sm.git"
set :repo_tree, "/tg_gateway_microservice"
set :use_sudo, true
set :rvm_type, :user
set :rvm_map_bins, %w{gem rake ruby rails bundle}

set :pty, true #if you don't do this you'll get a tty sudo error on EC2
set :ssh_options, {
  keys: [File.join(ENV["HOME"], ".ssh", "id_rsa")]
}

set :keep_releases, 4  # only keep 4 version to save space
set :copy_exclude, [".git",".gitignore","/app/config/database.yml"]
set :normalize_asset_timestamps, false

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "ln -nfs #{deploy_to}/shared/system #{release_path}/public/system"
      execute "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
      #execute "ln -nfs #{deploy_to}/shared/config/master.key #{release_path}/config/master.key"
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
  after :publishing, :restart
end