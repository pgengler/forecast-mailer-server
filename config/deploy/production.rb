server 'hyperion.pgengler.net', user: 'forecast-mailer', roles: %w{web app db}
set :rails_env, :production
set :bundle_binstubs, nil
set :rvm_ruby_version, '2.4.1@forecast-mailer'
