server 'hyperion.pgengler.net', user: 'forecast-mailer', roles: %w{web app db}
set :rails_env, :production
set :bundle_binstubs, nil
set :rvm_ruby_version, '2.6.5@forecast-mailer'
