require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0
    config.exceptions_app = routes

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = 'Dublin'

    # config.eager_load_paths << Rails.root.join("extras")
    config.autoload_paths << Rails.root.join('lib')

    config.active_job.queue_adapter = :sidekiq

    # For email images
    config.action_mailer.asset_host = Rails.application.credentials.dig(:host, :url)

    # Set devise to use app email layout
    config.to_prepare do
      Devise::Mailer.layout 'mailer'
    end
  end
end
