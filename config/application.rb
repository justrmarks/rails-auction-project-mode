require_relative 'boot'
require 'date'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsAuctionProjectMode
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.time_zone = 'Central Time (US & Canada)'
    config.active_record.default_timezone = :local
    config.active_storage.service = :local
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.assets.enabled = true
    config.assets.paths << Rails.root.join('/app/assets/fonts')
    config.assets.paths << Rails.root.join('/app/assets/images')
  end
end
