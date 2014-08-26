require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WeatherForecasts
	class Application < Rails::Application
		config.action_mailer.smtp_settings = {
			address: 'smtp.mandrillapp.com',
			port: 587,
			user_name: Rails.application.secrets.mandrill_username,
			password: Rails.application.secrets.mandrill_password,
		}
	end
end
