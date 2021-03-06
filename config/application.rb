require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ForecastMailer
  class Application < Rails::Application
    config.action_mailer.smtp_settings = {
      address: 'smtp.mailgun.org',
      port: 587,
      user_name: Rails.application.secrets.smtp_username,
      password: Rails.application.secrets.smtp_password,
    }
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
