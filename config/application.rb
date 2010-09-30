require File.expand_path('../boot', __FILE__)

require 'rails/all'


Bundler.require(:default, Rails.env) if defined?(Bundler)

module Booklog
  class Application < Rails::Application

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"
    
    # JavaScript files you want as :defaults (application.js is always included).
    config.action_view.javascript_expansions[:defaults] = %w(http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js rails)

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
  end
end
