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
{ 'attribute_normalizer'  => {},
  'authlogic'             => {},
  'compass'               => {},
  'cucumber'              => { :env => :test },
  'cucumber-rails'        => { :env => :test },
  'database_cleaner'      => { :env => :test },
  'haml'                  => {},
  'inherited_resources'   => { :version => '1.0.6' },
  'factory_girl'          => { :env => :test },
  'flash_messages_helper' => {},
  'metric_fu'             => { :env => :test },
  'pickle'                => { :env => :test },
  'rspec'                 => { :env => :test },
  'rspec-rails'           => { :env => :test },
  'searchlogic'           => {},
  'settingslogic'         => {},
  'shoulda'               => { :env => :test },
  'timecop'               => { :env => :test },
  'will_paginate'         => {},
  'webrat'                => { :env => :test },
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
download 'http://code.jquery.com/jquery-1.4.js', 'public/javascripts/jquery-1.4.js'
download 'http://ajax.microsoft.com/ajax/jquery.validate/1.7/jquery.validate.js', 'public/javascripts/jquery.validate.js'

file "public/javascripts/application.js", load_pattern("public/javascripts/application.js")

# Setup the default css environment
file "public/stylesheets/sass/application.sass", load_pattern("public/stylesheets/application.sass")

commit_state "Deveopment Environment Setup"

generate('rspec')
generate('cucumber')
generate('pickle')

# Delete Unessesary Files and Directories
[ 'spec/fixtures'
].each { |file| delete(file) }

commit_state "Testing Environment Setup"