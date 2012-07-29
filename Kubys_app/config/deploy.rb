set :application, 'kubys'
set :repository,  'ssh://root@78.47.35.172/home/git/kubys.git'
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server '78.47.35.172', :app, :web, :db, primary: true
set :user, 'root'
set :use_sudo, false
set :deploy_to, '/srv/www/kubys'
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
#
# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
#
# # Load RVM's capistrano plugin.
require "rvm/capistrano"
#
set :rvm_ruby_string, '1.9.3'
#set :rvm_type, :user  # Don't use system-wide RVM
set :git_enable_submodules, 1

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :bundle, roles: :app do
    run "cd #{current_path} && bundle"
  end
end

namespace :db do
  task :create_config_symlink, roles: :app, except: { :no_release => true } do
    run "ln -sf #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

namespace :chmod do
  task :tmp, roles: :app do
    run "chmod o+w #{release_path}/tmp"
  end

  task :uploads, roles: :app do
    run "mkdir #{release_path}/public/uploads && chmod o+w #{release_path}/public/uploads"
  end
end

after 'deploy:create_symlink', 'chmod:tmp', 'chmod:uploads', 'deploy:bundle'
