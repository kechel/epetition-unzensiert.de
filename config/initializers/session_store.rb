# Be sure to restart your server when you modify this file.

require 'action_dispatch/middleware/session/dalli_store'
Rails.application.config.session_store :dalli_store, :memcache_server => ['127.0.0.1'], :namespace => 'epetition-unzensiert', :key => '_session-epetition-unzensiert', :expire_after => 40.minutes

