# config valid only for Capistrano 3.8
lock '3.8.1'

set :application, 'forecast-mailer'
set :repo_url, 'git@github.com:pgengler/forecast-mailer.git'
set :ssh_options, { forward_agent: true }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/srv/apps/forecast-mailer'

# Default value for :linked_files is []
set :linked_files, %w{ .env }

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

	desc 'Restart application'
	task :restart do
		on roles(:app) do
			invoke 'puma:restart'
		end
	end

	after :publishing, :restart
end
