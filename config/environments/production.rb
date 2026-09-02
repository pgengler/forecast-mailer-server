require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot for better performance and memory usage.
  config.eager_load = true

  # Full error reports are disabled.
  config.consider_all_requests_local = false

  # Enable serving of images, stylesheets, and JavaScripts from the `/public` folder.
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  # nginx terminates SSL and forwards X-Forwarded-Proto: https. Trust it so
  # Rails generates https:// URLs without issuing 301 redirects (API-only app).
  config.assume_ssl = true

  # Do not force SSL redirects — nginx handles TLS termination, and force_ssl
  # would 301-redirect JSON API clients in ways that break them.
  # config.force_ssl = true

  # Log to STDOUT with the current request id.
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.log_tags = [:request_id]

  # Use the default logging formatter so PID and timestamp are not suppressed.
  config.log_formatter = Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger = ActiveSupport::Logger.new($stdout)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  # Replace the default Active Support logger with a thread-safe one.
  config.active_support.logger = config.logger

  # Cache classes for performance.
  config.cache_classes = true

  # Use a real queuing backend for Active Job.
  config.active_job.queue_adapter = :solid_queue

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true to raise delivery errors during development/test.
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false

  # Enable locale fallbacks for I18n.
  config.i18n.fallbacks = true

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Only use :id for inspections in production.
  config.active_record.attributes_for_inspect = [:id]

  # Enable DNS rebinding protection and other `Host` header attacks.
  # config.hosts << "forecast-mailer.pgengler.net"
  # Skip DNS rebinding protection for the default health check endpoint.
  # config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
end
