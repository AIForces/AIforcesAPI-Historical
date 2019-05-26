require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AIforces
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.autoload_paths += %W(#{config.root}/lib)

    # Set Moscow Time
    config.time_zone = 'Europe/Moscow'
    config.active_record.default_timezone = :local # Or :utc

    # Disable logging data from judge
    config.filter_parameters << lambda do |k, v|
      if k == 'log' && v && v.class == String && v.length > 100
        v.replace('[FILTER]')
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
