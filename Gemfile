source 'https://rubygems.org'

ruby '4.0.6'

# Use individual railties instead of the full rails metagem to avoid pulling
# in actioncable, actionmailbox, actiontext, and sprockets-rails (not needed
# for this API-only app). This also avoids building unnecessary native extensions
# like nio4r (actioncable) in the Docker image.
gem 'railties', '~> 8.1.0'
gem 'activesupport', '~> 8.1.0'
gem 'activemodel', '~> 8.1.0'
gem 'activerecord', '~> 8.1.0'
gem 'activejob', '~> 8.1.0'
gem 'actionpack', '~> 8.1.0'
gem 'actionmailer', '~> 8.1.0'
gem 'actionview', '~> 8.1.0'
gem 'jsonapi-resources', github: 'speee/jsonapi-resources', tag: 'v26.1.1'
gem 'pg'

gem 'solid_queue'
gem 'thruster', require: false

gem 'geocoder'

gem 'puma', '>= 6'
gem 'bootsnap', require: false

group :development do
  gem 'listen', '~> 3.5'
end

group :development, :test do
  gem 'factory_bot_rails'
end

gem 'kamal', require: false
