require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module EpetitionUnzensiert
  class Application < Rails::Application
    config.time_zone = 'Berlin'
    config.autoload_paths += %W( #{config.root}/lib)
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale = :de
    config.action_controller.perform_caching = true
    config.cache_store = :mem_cache_store, '127.0.0.1', { :namespace => 'epetition-unzensiert-cache-store', :expires_in => 40.minutes }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :address              => "localhost",
      :port                 => 25,
#      :domain               => 'xyz',
#      :user_name            => '<username>',
#      :password             => '<password>',
      :authentication       => 'plain',
#      :enable_starttls_auto => true,
      :enable_starttls_auto => false,
#      :openssl_verify_mode => 'none',
    }
  end
end
