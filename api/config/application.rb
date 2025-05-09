require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.api_only = true
    config.x.cors_allowed_origins = ENV.fetch('API_CORS_ALLOW_ORIGINS', 'http://localhost:3000')
    config.time_zone = 'Asia/Tokyo'
    config.active_record.default_timezone = :local
    config.autoload_paths += Dir["#{config.root}/decorators"]
    config.autoload_paths += Dir["#{config.root}/app/serializers/concerns"]
    config.i18n.load_path += Dir[Rails.root.join("config",
                                                 "locales", "**", "*.{rb,yml}").to_s]
    config.i18n.available_locales = [:en, :ja]
    config.i18n.default_locale = :ja
    config.i18n.fallbacks = [I18n.default_locale]

    config.reload_classes_only_on_change = true

    config.active_job.queue_adapter = :sidekiq

    config.autoload_paths += Dir["#{config.root}/lib"]
    config.eager_load_paths += Dir["#{config.root}/lib/**/"]

    config.generators do |g|
      g.template_engine :slim
      g.test_framework :rspec,
                       fixture: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: false,
                       request_specs: true,
                       system_specs: false

      g.fixture_replacement :factory_bot, dir: "spec/factories"
      g.helper false
      g.assets false
      g.decorator false
    end
  end
end
