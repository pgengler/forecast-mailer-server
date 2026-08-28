require_relative "boot"

# Select only the frameworks needed by this API-only app:
#   - rails (railties)
#   - active_record (database ORM)
#   - active_job (background jobs via Solid Queue)
#   - action_controller (API controllers)
#   - action_mailer (sending forecast emails)
# Skip: action_mailbox, action_text, action_cable, active_storage, sprockets
require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ForecastMailer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.action_mailer.smtp_settings = {
      address: "smtp.mailgun.org",
      port: 587,
      user_name: Rails.application.credentials.smtp_username,
      password: Rails.application.credentials.smtp_password,
    }
  end
end
