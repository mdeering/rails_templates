require File.join(File.expand_path(File.dirname(template), File.join(root,'..')), 'template_framework')

log template

init_template_framework template, root
add_template_path File.expand_path(File.join(ENV['HOME'],'.rails_templates')), :prepend
# load_options

# Delete Unessesary Files
[ 'public/favicon.ico', 'public/index.html', 'public/javascripts/*'
].each { |file| delete(file) }

# Set up git repository
git :init

# Set up gitignore and commit base state
file '.gitignore', load_pattern('.gitignore')

commit_state "base application"

# Install Gems
{ 'authentication_system'  => {},
  'attribute_normalizer'   => {},
  'authlogic'              => {},
  'compass'                => {},
  'cucumber'               => { :env => :test },
  # 'cucumber-rails'         => { :env => :test },
  'database_cleaner'       => { :env => :test },
  'haml'                   => {},
  'inherited_resources'    => { :version => '1.0.6' },
  'factory_girl'           => { :env => :test },
  'fast_context'           => { :env => :test },
  'flash_messages_helper'  => {},
  'formtastic'             => {},
  'metric_fu'              => { :env => :test },
  'pickle'                 => { :env => :test },
  'rspec'                  => { :env => :test, :lib => false },
  'rspec-rails'            => { :env => :test, :lib => false },
  'searchlogic'            => {},
  'settingslogic'          => {},
  'shoulda'                => { :env => :test },
  'timecop'                => { :env => :test },
  'will_paginate'          => {},
  'webrat'                 => { :env => :test },
}.each { |gem_name, options| gem gem_name, options }

# Install Plugins
{ 'annotate_models' => { :git => 'git://github.com/mdeering/annotate_models.git' },
  'asset_packager'  => { :git => 'git://github.com/sbecker/asset_packager.git' }
}.each { |plugin_name, options| plugin plugin_name, options }

commit_state "Gems and plugins added to the application"

# Setup the configuration Files
[ 'asset_packages.yml', 'database.yml', 'settings.yml' ].each do |config_file|
  file "config/#{config_file}.template", load_pattern("config/#{config_file}", 'default', binding)
  file "config/#{config_file}", load_pattern("config/#{config_file}", 'default', binding)
end

# Setup the default javascript evnironment
# download 'http://code.jquery.com/jquery-1.4.js', 'public/javascripts/jquery-1.4.js'
# download 'http://ajax.microsoft.com/ajax/jquery.validate/1.7/jquery.validate.js', 'public/javascripts/jquery.validate.js'

file "public/javascripts/application.js", load_pattern("public/javascripts/application.js")

# Setup the compass environment
# NEEDED: Compass install command
file "public/stylesheets/sass/application.sass", load_pattern("public/stylesheets/application.sass")

commit_state "Deveopment Environment Setup"

generate('rspec')
generate('cucumber')
generate('pickle')

# Delete Unessesary Files and Directories
[ 'spec/fixtures'
].each { |file| delete(file) }

commit_state "Testing Environment Setup"

# Bring over the user and authroization stuff.

# NEEDED: Look for timestamped_migrations for how to bring over the user migration under the right name.
file "db/migrate/001_create_users.rb", load_pattern("db/migrate/001_create_users.rb")

# Specs
file "spec/models/user_spec.rb", load_pattern("spec/models/user_spec.rb")
file "spec/factories/users.rb", load_pattern("spec/factories/users.rb")
file "spec/spec_helper.rb", load_pattern("spec/spec_helper.rb")
file "spec/spec.opts", load_pattern("spec/spec.opts")

# Features
[ :login, :nervecenter, :signup ].each do |feature|
  file "features/#{feature}.feature", load_pattern("features/#{feature}.feature")
end

file "features/step_definitions/authentication_steps.rb", load_pattern("features/step_definitions/authentication_steps.rb")
file "features/support/env.rb", load_pattern("features/support/env.rb")
file "features/support/paths.rb", load_pattern("features/support/paths.rb")

# Models
[ :user, :user_session ].each do |model|
  file "app/models/#{model}.rb", load_pattern("app/models/#{model}.rb")
end

# Views
[ 'layouts/application', 'layouts/nervecenter/base', 'nervecenter/index',
  'site/index', 'user_sessions/new', 'users/new', 'users/show' ].each do |view|
  file "app/views/#{view}.html.haml", load_pattern("app/views/#{view}.html.haml")
end


# Controllers
[ :application, :site, :user_sessions, :users ].each do |controller|
  file "app/controllers/#{controller}_controller.rb", load_pattern("app/controllers/#{controller}_controller.rb")
end
[ :base, :users ].each do |controller|
  file "app/controllers/nervecenter/#{controller}_controller.rb", load_pattern("app/controllers/nervecenter/#{controller}_controller.rb")
end

# Environment and Locales
[ 'environment.rb', 'locales/flash/en.yml', 'locales/formtastic/en.yml' ].each do |config_file|
  file "config/#{config_file}", load_pattern("config/#{config_file}")
end

# Routes
# NEEDED: Is there a better way to do routes in templates?
file "config/routes.rb", load_pattern("config/routes.rb")

rake 'db:create:all'
rake 'db:migrate'
rake 'spec'
rake 'cucumber:a;;'

commit_state "User model, authentication, and nervecenter"
