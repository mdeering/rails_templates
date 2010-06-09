# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  config.gem 'attribute_normalizer'
  config.gem 'authentication_system'
  config.gem 'authlogic'
  config.gem 'compass'
  config.gem 'flash_messages_helper'
  config.gem 'formtastic'
  config.gem 'haml'
  config.gem 'inherited_resources', :version => '1.0.6'
  config.gem 'searchlogic'
  config.gem 'settingslogic'
  config.gem 'validation_reflection'
  config.gem 'will_paginate'

  config.time_zone = 'UTC'

  config.i18n.load_path += Dir[File.join(RAILS_ROOT, 'config', 'locales', '**', '*.{rb,yml}')]
  config.i18n.default_locale = :en

end