require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KiraMclean
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    config.generators do |generate|
      generate.helper false
      generate.test_framework :rspec
      generate.request_specs false
      generate.routing_specs false
      generate.view_specs false
    end

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins /(http:\/\/|https:\/\/)kiramclean.surge.sh/,
          'http://localhost:4200'
        resource '*', headers: :any, methods: [:get, :post, :options]
      end
    end
  end
end
